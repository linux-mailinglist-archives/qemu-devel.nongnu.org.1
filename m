Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E597C56BD
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:25:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqa91-00080n-J5; Wed, 11 Oct 2023 10:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqa90-00080U-6Z
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:25:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqa8y-0002eP-LO
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697034300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VmXuULuP8drksA2GOn7/wNPQW+POBIgDUuGV496Sad0=;
 b=hAh1Ya7+RwiWNIJctlxMzkauaqkt7EjPTEbx2YCxjdcdMA8FMeH+5HDpKxwRdEXUGdz3NU
 PPPWFA54+XkUTBwjSIE0FQ9Fm2ig/5QHCvmgPdMoTD8HQbNA/kDNb5fFc67ZdWSRX/ESRJ
 SYisqWtXj01Vx8Ln1Gxrlq6hq7/RP14=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-iffVEHa4M_mElKhcBjmekw-1; Wed, 11 Oct 2023 10:24:58 -0400
X-MC-Unique: iffVEHa4M_mElKhcBjmekw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-419719b700aso14253091cf.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034298; x=1697639098;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VmXuULuP8drksA2GOn7/wNPQW+POBIgDUuGV496Sad0=;
 b=Jwz6ubsY9ihSli67VnrSkm5WXdwb4An6oWd2HVZL0zQeCu0UDq0/MDeAbm1JANohjP
 JUMaksjJ84X03hzqoKfDSskRZ3efZD99cYYMjXZmzS/u1AxGs5+/AFMmNYcbTGIIXqTS
 tHNxISN+yhhqR2vQGhJWTWiauuB9QsBupz76QKzWyprjJ8up4f9fR7G3LOmNq0ZhfS33
 yG012I0tJy8KuQ5Evg31ZG9zSUt+nDQx3qkC72Z15nJG5CE8i6wBy1tTP0lKMXKi8MtX
 H3I6r7eelYN6rNxBf71p6K791kBtEpQ7tgqXI5MtSIVxhg8sEMgIGeY6Krv60ZFGfRmQ
 KdTQ==
X-Gm-Message-State: AOJu0Yz9og6pKe3EzHKM2qZafwyCASD37eCkwIIraCw42K70Nmn+1mQ5
 wfKG2Wvxjsbene4O4E5v8nXr7IxX2kbA8LeY6kgs6iY8rh4otWgMyLkfH84zHhGXbPl7FYAcqlo
 I5WfWvx4wcQ8nb9A=
X-Received: by 2002:a05:622a:282:b0:40f:dcda:ea10 with SMTP id
 z2-20020a05622a028200b0040fdcdaea10mr23011183qtw.3.1697034298204; 
 Wed, 11 Oct 2023 07:24:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFNNkGkmE2CnmyG66M6DJVAyDrgzdLF9z3cWe0C2k0tGu1RBy8U4yV8OpzLo+wbDfuG8ydGg==
X-Received: by 2002:a05:622a:282:b0:40f:dcda:ea10 with SMTP id
 z2-20020a05622a028200b0040fdcdaea10mr23011167qtw.3.1697034297881; 
 Wed, 11 Oct 2023 07:24:57 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 os22-20020a05620a811600b007757acf488esm5253883qkn.39.2023.10.11.07.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:24:57 -0700 (PDT)
Date: Wed, 11 Oct 2023 10:24:55 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: Re: [PATCH v1] migration: fix RAMBlock add NULL check
Message-ID: <ZSawNzXp523+/sDe@x1n>
References: <20231010104851.802947-1-frolov@swemel.ru> <ZSWkvPH0asP8xXSu@x1n>
 <04093899-57e7-75bf-5b16-0ec08708a2d0@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04093899-57e7-75bf-5b16-0ec08708a2d0@swemel.ru>
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

On Wed, Oct 11, 2023 at 04:20:42PM +0300, Дмитрий Фролов wrote:
> I do not insist on accepting this patch - it is more like RFC.
> Also, i can add more verbose message and assert, if necessary.

That's totally fine. It's just that then we should drop the Fixes line
above because it doesn't need to be backported to stable.

Also feel free to add more verbose print message or assert if you're
posting a new version.

Thanks,

-- 
Peter Xu


