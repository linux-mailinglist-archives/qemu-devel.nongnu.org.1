Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E6883FD29
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Jan 2024 05:17:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUJ4G-0001SR-6v; Sun, 28 Jan 2024 23:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rUJ49-0001RK-1P
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 23:16:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rUJ47-0006pm-52
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 23:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706501767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lFPxgHkaZtgEfDEjW//7KcL+n/pHQxld1NiHJnZUE5A=;
 b=BswSC7vpLtDJeNfOk0l6ivY+30JdWZ6IyW2I3u0Ufsy5ERP4IIOMqy+rgZtW7bI7yGLayR
 5s10BdeBAXrCnenIO1BdrD3RDQJhZew0LE9YA7fOoXzJ87I4B+XUajFqysm5uBuWbcjDZ8
 f+uz8j9sKtBLc6t/a+YQGrTi+ESq5S0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-zljvvsyNM32RYTEcHu_c5g-1; Sun, 28 Jan 2024 23:16:05 -0500
X-MC-Unique: zljvvsyNM32RYTEcHu_c5g-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-68c46abd598so11846816d6.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 20:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706501765; x=1707106565;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFPxgHkaZtgEfDEjW//7KcL+n/pHQxld1NiHJnZUE5A=;
 b=vDR5HUc07MGQzgF0usvPnzoo8FZPMdFtqt0GgRtiyDjlDCuOa5Ddc8nQHhx0rwNXp/
 1HrYxuxgSSu8o+o0rmxJ/TuqxmhhjSxdJgRxOAdIBZ2m2AXkuNjMotemCJVt4zmv5+vL
 9CFj5UwqoXkdILNTjo+BWxuw7R4+yfw6otDcjDN7Ax9HyF0s30AZhbM5rtcTN5sGpF+3
 9PY2ODX37SbxHgEOoT4z2wXh+xFY4dYRox5CfL667IM1uCjZypKQj6O6JwdIm+/iKx88
 ZRaigk3dJYfLoWYO1kCzb4h8KLfpEEbKaxAPBGahnI/48osmztm7MgVeED3f1qgBVd59
 x1lA==
X-Gm-Message-State: AOJu0YwacUWcC3xMnkMuE6kS0M02uE1g3PShOQhecV7dzTYQJuOBM0Io
 OIdiS+m7w3wAEW9/SiC5gbv9XcPcEajqUxwB+Qzh8Tzzz5gSUgAwZgaOnGcitxXPPQR+7XZt4Cj
 GJMYhHsbl0jEvqfxit2VO5P0iU0kyoJ4gEGLi1MFokT12mXNpBU5x
X-Received: by 2002:ad4:5c46:0:b0:68c:44f6:c858 with SMTP id
 a6-20020ad45c46000000b0068c44f6c858mr4692917qva.86.1706501764824; 
 Sun, 28 Jan 2024 20:16:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcdeKL2O/4zY1zTF5Jrx5JHFzhjG775WhJu44UiAHK5WHdkKOszyvDJkT2jn4+QVAyvKf1aw==
X-Received: by 2002:ad4:5c46:0:b0:68c:44f6:c858 with SMTP id
 a6-20020ad45c46000000b0068c44f6c858mr4692900qva.86.1706501764568; 
 Sun, 28 Jan 2024 20:16:04 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-119.web.vodafone.de.
 [109.43.176.119]) by smtp.gmail.com with ESMTPSA id
 kr5-20020a0562142b8500b0068c3aeb4213sm2196347qvb.57.2024.01.28.20.16.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jan 2024 20:16:04 -0800 (PST)
Message-ID: <a7ee1d55-f550-4ad9-9907-f9dd13600aa0@redhat.com>
Date: Mon, 29 Jan 2024 05:16:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/scsi/lsi53c895a: add missing decrement of reentrancy
 counter
To: Sven Schnelle <svens@stackframe.org>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Alexander Bulekov <alxndr@bu.edu>
References: <20240128202214.2644768-1-svens@stackframe.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240128202214.2644768-1-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 28/01/2024 21.22, Sven Schnelle wrote:
> When the maximum count of SCRIPTS instructions is reached, the code
> stops execution and returns, but fails to decrement the reentrancy
> counter. This effectively renders the SCSI controller unusable
> because on next entry the reentrancy counter is still above the limit.
> 
> This bug was seen on HP-UX 10.20 which seems to trigger SCRIPTS
> loops.

Out of curiosity: What happened there before we introduced the 
reentrancy_level fix? Did it end up in an endless loop, or was it finishing 
at one point? In the latter case, we might need to adjust the 
"reentrancy_level > 8" to allow deeper nesting.

> Fixes: b987718bbb ("hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI controller (CVE-2023-0330)")
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   hw/scsi/lsi53c895a.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 34e3b89287..d607a5f9fb 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -1159,6 +1159,7 @@ again:
>           lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
>           lsi_disconnect(s);
>           trace_lsi_execute_script_stop();
> +        reentrancy_level--;
>           return;
>       }
>       insn = read_dword(s, s->dsp);

Reviewed-by: Thomas Huth <thuth@redhat.com>


