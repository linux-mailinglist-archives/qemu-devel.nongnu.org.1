Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 419A0746D40
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:24:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGcGV-0005S6-JX; Tue, 04 Jul 2023 05:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGcGU-0005Rx-CV
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGcGS-0004wi-Bi
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688462642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lPdgolsSNx1uHcv78FY9bbZuYEdFAgk/cd9parA4ujY=;
 b=GpRFDNgB/vO+rVVzKif+/yNsaEWnLHnR1lZ70xLXn02UXTHfP/zt7YMLhvdBVL7A7CcYLZ
 MZh769KpLRry/bLkkKl6gtEmZi8DD6r8WHWyYh9Cxe0B2WGvgyhuIL21NcBbGggEDJu8u3
 agxr3SpVMy5KUwB1D4yLiAPXaq2tgyg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-fTXCQaYVNaChbRf3lNZs_g-1; Tue, 04 Jul 2023 05:24:00 -0400
X-MC-Unique: fTXCQaYVNaChbRf3lNZs_g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-635984f84a9so55540076d6.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 02:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688462639; x=1691054639;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lPdgolsSNx1uHcv78FY9bbZuYEdFAgk/cd9parA4ujY=;
 b=N+RvA/V3nUm4/JBBLg/kOMtcAlI/FSP2s9N3I3HRjKxOT9lSKYiiI8Sclvuj8DxffQ
 oUZBHGNKeV4zXj7Y5iajiVnXZblcgNO0eNgQOFQ8ddLJjTEqS4CGOVhAGtIO8uWgjgDk
 v4+cUEFLIK1LJuI4x5qqZL2QNfBukYAJ1++GvNmiWBjTTfs6qwMxJNEQsl5caoywgPKv
 r82JzyeHQI2CX1dyIu+4AWZ6NI+WGnE0Zq7mBUgzjJ6ufivHgApwjF/pJWd9bYJNsTra
 yP000SMY2+/Mvd8u3SMStUe6IH91KfuS8r4KyLMJOUBG535mQbyk6T29jJIcILKIAM13
 vISg==
X-Gm-Message-State: ABy/qLYFEDFeZiwmQ/CTHowlhac2i9ZTy6oHpkFACVx6tGjQ6h1noqqA
 NOUL4C2sYBFwY0TqZ4MpYzNIzrLn6EX8Qnq6krWp9mkgOUpWNAt5y4rqWLIlE44VFvpCNV63/Fc
 n4wYDj3oRHBYpWus=
X-Received: by 2002:ad4:5baf:0:b0:632:ab5:2d6c with SMTP id
 15-20020ad45baf000000b006320ab52d6cmr12915990qvq.27.1688462639746; 
 Tue, 04 Jul 2023 02:23:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEZHl/gIp9zlr2QS2ZL2TOoVWX2own5f1pdHcBraRCAkLtneivpYDi9anT0O8ZaaTmFDqowRg==
X-Received: by 2002:ad4:5baf:0:b0:632:ab5:2d6c with SMTP id
 15-20020ad45baf000000b006320ab52d6cmr12915977qvq.27.1688462639536; 
 Tue, 04 Jul 2023 02:23:59 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-126.web.vodafone.de.
 [109.43.179.126]) by smtp.gmail.com with ESMTPSA id
 p11-20020a0cf68b000000b0063645f62bdasm5336449qvn.80.2023.07.04.02.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 02:23:59 -0700 (PDT)
Message-ID: <8637f500-88af-1f57-9f4b-88a9405e89cf@redhat.com>
Date: Tue, 4 Jul 2023 11:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] virtio-gpu: fix potential divide-by-zero regression
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: alxndr@bu.edu, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20230704091933.2342193-1-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230704091933.2342193-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 04/07/2023 11.19, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Commit 9462ff4695aa0 ("virtio-gpu/win32: allocate shareable 2d
> resources/images") introduces a division, which can lead to crashes when
> "height" is 0.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1744
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
...
> diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> index b0f44f929a..c8971e90ac 160000
> --- a/tests/lcitool/libvirt-ci
> +++ b/tests/lcitool/libvirt-ci
> @@ -1 +1 @@
> -Subproject commit b0f44f929a81c0a604fb7fbf8afc34d37ab0eae9
> +Subproject commit c8971e90ac169ee2b539c747f74d96c876debdf9

That submodule update looks like an accident?

  Thomas


