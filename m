Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC18770E99
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 09:56:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSC8y-0002o8-LX; Sat, 05 Aug 2023 03:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qSC8x-0002nT-Fz
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 03:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qSC8v-00064Y-GG
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 03:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691222168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nj/QNVs2e0A/Tts8D8emA3uz4RAjSxgvrUMDfyFYX2A=;
 b=cnxTIptd+9V1OIr6AbNgYez2D2SlzzQErCZPtrNgoyTLJRpkJ2Ytx0Kle7KYTYZkL3p/Jq
 E0KYcCGNVnLaOYC8W9BhRiGDbrsYibGRHWRuylJVZMir7RoPirU8xS9KYlnj41S38+dyHb
 EEY+jp9Dxw6t28S7Xd1c5rFJq2JtuPM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-K1xBWerOO5id8wbQ46qbLA-1; Sat, 05 Aug 2023 03:56:05 -0400
X-MC-Unique: K1xBWerOO5id8wbQ46qbLA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-317d5b38194so523087f8f.0
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 00:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691222164; x=1691826964;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nj/QNVs2e0A/Tts8D8emA3uz4RAjSxgvrUMDfyFYX2A=;
 b=QHJlBcaomr/ytAsPvXK19J1m87S3IPndMtnuzkHS4BheTo0/hW+Mqr6lU8tY/EoR40
 VPhtJRklAejNL+XJOoMp4Ol9bIO/BejU1hGINeY/GSFl5k8jstbbgnFMuX/8A9F2rpTk
 JOR0gPv5+h/J0lsUFHfs8SyxZ5BOuJ1czW2B/RoIIpgxqj0qPfBTvV2I05vfSiN7vStG
 ULqkD7rfV5yT/8OpFwH3gQk1LFoCEjSY5JGly/711h4LumBR/kqQwBPKzifUgkOhK2Fe
 cRE2MhiiMVyG/Z5rE5Td07uQhC4u+JA29gVPBc54d9t2kYO1npBWFOQo12ApiTYIwYYx
 T9AA==
X-Gm-Message-State: AOJu0YyjYu7GmVkTiGLDsvCVvTInALntL5R41zltvY+CsrNVFsoB8Ryg
 1e0p0pVFD61Eid4QgsFUnq6dgHI0zmITVT5Otw1UHlGEd/ZLrTwKmpBRZZ2Nzv70YCdz0OJmcFn
 2k1JBy3ogRN/P2tw=
X-Received: by 2002:a5d:620f:0:b0:315:acbc:cab6 with SMTP id
 y15-20020a5d620f000000b00315acbccab6mr1150294wru.16.1691222164464; 
 Sat, 05 Aug 2023 00:56:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmJ/wHWlrs1kNMjln51vYAAiMqWGaqHj5nQ/tnjSChK6VFVTjMHXsvkMZyfOLx4y4xyGF3YQ==
X-Received: by 2002:a5d:620f:0:b0:315:acbc:cab6 with SMTP id
 y15-20020a5d620f000000b00315acbccab6mr1150271wru.16.1691222163918; 
 Sat, 05 Aug 2023 00:56:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2d:8e00:a20e:59bc:3c13:4806?
 (p200300d82f2d8e00a20e59bc3c134806.dip0.t-ipconnect.de.
 [2003:d8:2f2d:8e00:a20e:59bc:3c13:4806])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a5d4204000000b003143867d2ebsm4459045wrq.63.2023.08.05.00.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Aug 2023 00:56:03 -0700 (PDT)
Message-ID: <63c3447f-83d2-1b04-7975-e00bf478b718@redhat.com>
Date: Sat, 5 Aug 2023 09:56:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/s390x: Check reserved bits of VFMIN/VFMAX's M5
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-stable@nongnu.org
References: <20230804234621.252522-1-iii@linux.ibm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230804234621.252522-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 05.08.23 01:46, Ilya Leoshkevich wrote:
> VFMIN and VFMAX should raise a specification exceptions when bits 1-3
> of M5 are set.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: da4807527f3b ("s390x/tcg: Implement VECTOR FP (MAXIMUM|MINIMUM)")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/translate_vx.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/tcg/translate_vx.c.inc b/target/s390x/tcg/translate_vx.c.inc
> index f8df121d3d3..b5d07d5ec53 100644
> --- a/target/s390x/tcg/translate_vx.c.inc
> +++ b/target/s390x/tcg/translate_vx.c.inc
> @@ -3047,7 +3047,7 @@ static DisasJumpType op_vfmax(DisasContext *s, DisasOps *o)
>       const uint8_t m5 = get_field(s, m5);
>       gen_helper_gvec_3_ptr *fn;
>   
> -    if (m6 == 5 || m6 == 6 || m6 == 7 || m6 >= 13) {
> +    if (m6 == 5 || m6 == 6 || m6 == 7 || m6 >= 13 || (m5 & 7)) {
>           gen_program_exception(s, PGM_SPECIFICATION);
>           return DISAS_NORETURN;
>       }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


