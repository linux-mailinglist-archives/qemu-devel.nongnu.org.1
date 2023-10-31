Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC94F7DCCF2
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 13:27:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxnog-0006p8-S5; Tue, 31 Oct 2023 08:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qxnoe-0006mT-EY
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 08:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qxnoc-0006TB-Sw
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 08:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698755150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7+kBySAk44unfASEg0iPhCELuBvEajHzx7Y2ddSsUAA=;
 b=OvmprEzvN6pZMGEJVM1j5chYXa/rsE2DGeouAHkMwdyPcEyYC+Q7sV5v1RLDZ8ufmlClqs
 HQ/XUwhD7MVbET+2E8vDl/7Zu5MJiOP+5ApDIq/HtZXb0qOSphpJTNhO2sndkmzqag3Rz/
 hU4vZ7TyaoaYMUud2HVpczV3cshma1g=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-5OqfxQMMPRG5-DiS0FV96A-1; Tue, 31 Oct 2023 08:25:33 -0400
X-MC-Unique: 5OqfxQMMPRG5-DiS0FV96A-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-4a92ec4ded3so577283e0c.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 05:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698755133; x=1699359933;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+kBySAk44unfASEg0iPhCELuBvEajHzx7Y2ddSsUAA=;
 b=ptRNeJ2Xc04FU6xrCDYhz767a9beBQagFR3l1OGX6CGG0rTrgXD51SoEBVfg5Zk3fj
 B1tw/f2ov084hLx85egvy9G2RF1a5WFbLk4jfaHjTuQIEjvOjb7Xs32SRXcsH/LKoR+/
 lwP/YCPmmu9MwwckO9d8P19ZGki5Bhm8N2PBqvg0GHxM8f0TghikEY5Dp4Ydq1kQZjH0
 cUaEeOnSLC4OjdbtajnWCHoi3VN1CgAmSBsGdUMRsC/YegAXElzCVLnEGmoFrUxPmS6E
 /p9s5O6QP26oSGAWEVJR23lKfo9HwQBbaBZpAI0E3VS/Muc2j8hZ+QKZljsrxVKSSr48
 ZxhA==
X-Gm-Message-State: AOJu0Yy8a/5h8gc24jxuU7GPA0ZsZthSoDGQY9Y5nx3CqqfnwPpMJp0g
 bgUAIDN7o4oaSiqt5z9eRDdmw6t5M3N28+kEtZYI+ETX2EgqkYfHXxHbl7fDMhwxPmTx7wn6Qgw
 tkPpUpDxm/sfN8YM=
X-Received: by 2002:a1f:a243:0:b0:4a0:8a35:6686 with SMTP id
 l64-20020a1fa243000000b004a08a356686mr7733630vke.11.1698755133274; 
 Tue, 31 Oct 2023 05:25:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdn2VbQbp2tSlF1j1XNNediZwz748qnBxG+7Ggy8NSdPawwClaynNSNYSn8SUxdGFWqrnwkg==
X-Received: by 2002:a1f:a243:0:b0:4a0:8a35:6686 with SMTP id
 l64-20020a1fa243000000b004a08a356686mr7733605vke.11.1698755132898; 
 Tue, 31 Oct 2023 05:25:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:8f00:43b0:1107:57d2:28ee?
 (p200300cbc7078f0043b0110757d228ee.dip0.t-ipconnect.de.
 [2003:cb:c707:8f00:43b0:1107:57d2:28ee])
 by smtp.gmail.com with ESMTPSA id
 e194-20020a1f1ecb000000b0049d1de0fa44sm142285vke.28.2023.10.31.05.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 05:25:32 -0700 (PDT)
Message-ID: <016db1b3-5d02-401d-8171-78f8cff0b525@redhat.com>
Date: Tue, 31 Oct 2023 13:25:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] balloon: Fix a misleading error message
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, npiggin@gmail.com, danielhb413@gmail.com,
 clg@kaod.org, david@gibson.dropbear.id.au, harshpb@linux.ibm.com,
 dave@treblig.org, jasowang@redhat.com, michael.roth@amd.com,
 kkostiuk@redhat.com, mst@redhat.com, kraxel@redhat.com,
 marcandre.lureau@redhat.com, qemu-ppc@nongnu.org
References: <20231031111059.3407803-1-armbru@redhat.com>
 <20231031111059.3407803-7-armbru@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231031111059.3407803-7-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 31.10.23 12:10, Markus Armbruster wrote:
> The error message
> 
>      {"execute": "balloon", "arguments":{"value": -1}}
>      {"error": {"class": "GenericError", "desc": "Parameter 'target' expects a size"}}
> 
> points to 'target' instead of 'value'.  Fix:
> 
>      {"error": {"class": "GenericError", "desc": "Parameter 'value' expects a size"}}
> 
> Root cause: qmp_balloon()'s parameter is named @target.  Rename it to
> @value to match the QAPI schema.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   system/balloon.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/system/balloon.c b/system/balloon.c
> index e0e8969a4b..fda7af832e 100644
> --- a/system/balloon.c
> +++ b/system/balloon.c
> @@ -90,17 +90,17 @@ BalloonInfo *qmp_query_balloon(Error **errp)
>       return info;
>   }
>   
> -void qmp_balloon(int64_t target, Error **errp)
> +void qmp_balloon(int64_t value, Error **errp)
>   {
>       if (!have_balloon(errp)) {
>           return;
>       }
>   
> -    if (target <= 0) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "target", "a size");
> +    if (value <= 0) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "value", "a size");
>           return;
>       }
>   
> -    trace_balloon_event(balloon_opaque, target);
> -    balloon_event_fn(balloon_opaque, target);
> +    trace_balloon_event(balloon_opaque, value);
> +    balloon_event_fn(balloon_opaque, value);
>   }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


