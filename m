Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D027CFBF0
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:04:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTbs-0005YR-Fw; Thu, 19 Oct 2023 10:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtTbn-0005Xz-6s
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtTbi-0007Rg-Ta
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697724157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hd8qDkV5MhWsL/MpplvE5Oo9ct+HWtsusiuACxcgRF4=;
 b=bwWOM2djvvCIx/doU1702McxS58jgUdKwaTohmkM+kgxuRWtwPYpQnG/Z5bzjk2UMjLDbJ
 IQCrwQsEny8N0B6aD0jDmrUzGq26AyVX5PyDGPWuGFhNT/qD1RPxlL8e+IyY/mSqAcM8Ag
 xSbuXuv0YdwgBeN5avWFNU5RtxYEqPQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-uZOse6ZCNhCX0wzHy20w-A-1; Thu, 19 Oct 2023 10:02:35 -0400
X-MC-Unique: uZOse6ZCNhCX0wzHy20w-A-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-775842dc945so149915085a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 07:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697724154; x=1698328954;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hd8qDkV5MhWsL/MpplvE5Oo9ct+HWtsusiuACxcgRF4=;
 b=qmJ9UnJOQKMxXEodEiS7CUNdsl9+PBH+ifJxcntjoSF4O8EhYcA+oi0D9P2+8LzA+j
 i35ZXknx8asiQEjQfe3ZYrBOQnuUZnv+mkHtum0TAZS7W+gBecSLMGb1/bFcgst+uL06
 2sszpJ/dOyS19LNnmYrLdwxtVxdONAAiPL43Zxq8bGGiinkeA52q+T1Wkfi+oulVDoHP
 fzfNbrPjcYjYbPyfa2k3d2M0zFmbUb2c+7U44c0isWcaF+El+r1Rj0HTxBh47vSAXNeW
 wJ2MbW59rX/ASy+EdsiyfxdxbNG8SU6SbsRL6IaFHHRLU1DgV971ow3k+o+lV+g/z9TM
 ec8w==
X-Gm-Message-State: AOJu0YxAVB97mzIrpme9G3MOZN1rP01CKUBJ1gRNGTV051+OjsAoNWBk
 ypWl6ChN20tocwM6tHANa2lJDEZW0FcV69ZXPgcPjrPBCHEmXQRafBoFWnuCaKC05ZOq/7Ebagp
 Ikvum+6rqb+fLoGSYbZEm6yg=
X-Received: by 2002:ac8:4b52:0:b0:41c:c844:e078 with SMTP id
 e18-20020ac84b52000000b0041cc844e078mr1703746qts.4.1697724154409; 
 Thu, 19 Oct 2023 07:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH06qE3XzC9B4ZN7yhWcuWwKkiyT0J1hdUxxujeMgMQg0ZSs5mCanQ7V1wDGAKn6HC/Wd9/Uw==
X-Received: by 2002:ac8:4b52:0:b0:41c:c844:e078 with SMTP id
 e18-20020ac84b52000000b0041cc844e078mr1703714qts.4.1697724154034; 
 Thu, 19 Oct 2023 07:02:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h20-20020ac87774000000b004180fb5c6adsm751907qtu.25.2023.10.19.07.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 07:02:33 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:02:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: quintela@redhat.com, farosas@suse.de, leobras@redhat.com,
 qemu-devel@nongnu.org, nanhai.zou@intel.com
Subject: Re: [PATCH 2/5] qapi/migration: Introduce compress-with-iaa
 migration parameter
Message-ID: <ZTE2+Cj2WypqeC5x@x1n>
References: <20231018221224.599065-1-yuan1.liu@intel.com>
 <20231018221224.599065-3-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231018221224.599065-3-yuan1.liu@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Oct 19, 2023 at 06:12:21AM +0800, Yuan Liu wrote:
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8843e74b59..8edc622dd9 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -835,7 +835,7 @@
>  { 'enum': 'MigrationParameter',
>    'data': ['announce-initial', 'announce-max',
>             'announce-rounds', 'announce-step',
> -           'compress-level', 'compress-threads', 'decompress-threads',
> +           'compress-level', 'compress-threads', 'compress-with-iaa', 'decompress-threads',
>             'compress-wait-thread', 'throttle-trigger-threshold',
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'cpu-throttle-tailslow',
> @@ -1008,6 +1008,7 @@
>              '*announce-step': 'size',
>              '*compress-level': 'uint8',
>              '*compress-threads': 'uint8',
> +            '*compress-with-iaa': 'bool',
>              '*compress-wait-thread': 'bool',
>              '*decompress-threads': 'uint8',
>              '*throttle-trigger-threshold': 'uint8',
> @@ -1208,6 +1209,7 @@
>              '*announce-step': 'size',
>              '*compress-level': 'uint8',
>              '*compress-threads': 'uint8',
> +            '*compress-with-iaa': 'bool',
>              '*compress-wait-thread': 'bool',
>              '*decompress-threads': 'uint8',
>              '*throttle-trigger-threshold': 'uint8',

Please add comments for the new fields too in qapi/, thanks.

-- 
Peter Xu


