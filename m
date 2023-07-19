Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CE9759037
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 10:28:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM2WV-0008Pv-CZ; Wed, 19 Jul 2023 04:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qM2WS-0008On-5C
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 04:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qM2WP-00035a-HR
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 04:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689755211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aeOUgXQ3d1ZFv7cn1t7aQtIhwjtX8E3lOavdcq7CBfU=;
 b=OIuahKPZvKBiRAIeSLoTJ/d7wnS1korJ6Y2ei3dwm09QVDEPU/wUyraLg/rHSvPuwRBCqL
 UwmpRTbm7ahXIstGMB3lJNK8/iveI9ijCKIxoz80/PQzL2olDmFJDRvsQyvvv72Oiz8CRf
 lag9fB38ntQHdet+OF2YU2uUa8f25x0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-eBbV_UQLM4Ck1U1N57uhzw-1; Wed, 19 Jul 2023 04:26:49 -0400
X-MC-Unique: eBbV_UQLM4Ck1U1N57uhzw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-316f24a72e8so2862508f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 01:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689755208; x=1692347208;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aeOUgXQ3d1ZFv7cn1t7aQtIhwjtX8E3lOavdcq7CBfU=;
 b=I0Gtvp2nEwLrifjiW0+vJRule+moJ7HFbxXXpI+wa7QMFQaiyoks3ZpN6H57leDuhN
 M1YD5iqyiUs++ARIQaxRlLgR9WIYKpGoTo3SrOkd86ev5Ay7R23gFd4fyWK5lfq8CvAN
 MzoH+/NsxI7AopVRhPvXj0o/D2A2j5s9sL1WsRfsd5YJ0L5ajQShSFkGT8N41Qe1hDT0
 foLhXuKfTzn5bgKV6cd4avwiSR7L0wp2fB1F0nxGyCJHQTU7aKH7SEdefGhJr6DwGr0r
 tJH+mkwvjlQC6axpsWW44yphv2xxarFZ4K6i9lMhFcCq51pKAffmNkdEGPFZ5rsG4/Tx
 L8ZA==
X-Gm-Message-State: ABy/qLYhpbTJxORO7ruZGMsEIElCj/3MdQnav3sqyf0TOht5dVdgGBao
 l4lRV/v43X1czkSUBMlwzO8WUrKwaRoMs3B0VcfB2GE4zyfta/v3WNPM95yT6U7WXAMV4nSH2o5
 +EKa2RYi4klYxIwU=
X-Received: by 2002:a5d:6841:0:b0:314:1ebc:6e19 with SMTP id
 o1-20020a5d6841000000b003141ebc6e19mr14652690wrw.64.1689755208616; 
 Wed, 19 Jul 2023 01:26:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEcuzQGwQasFj52yq+SyYHslfqAZ1WcQFQfYLipx3FNqgmMSJ0MApet7HhWS4kIj1QhuzDimg==
X-Received: by 2002:a5d:6841:0:b0:314:1ebc:6e19 with SMTP id
 o1-20020a5d6841000000b003141ebc6e19mr14652678wrw.64.1689755208276; 
 Wed, 19 Jul 2023 01:26:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63?
 (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de.
 [2003:cb:c74b:4f00:b030:1632:49f2:63])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a5d63cd000000b0031431fb40fasm4607423wrw.89.2023.07.19.01.26.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 01:26:47 -0700 (PDT)
Message-ID: <8fadd08f-e1cb-3944-94d6-927f2fba0120@redhat.com>
Date: Wed, 19 Jul 2023 10:26:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/14] target/s390x: Make CKSM raise an exception if R2 is
 odd
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230718213531.117976-1-iii@linux.ibm.com>
 <20230718213531.117976-2-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230718213531.117976-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 18.07.23 23:21, Ilya Leoshkevich wrote:
> R2 designates an even-odd register pair; the instruction should raise
> a specification exception when R2 is not even.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e023e832d0ac ("s390x: translate engine for s390x CPU")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/translate.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index 6661b27efa4..2f61e879878 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -1991,11 +1991,18 @@ static DisasJumpType op_cxlgb(DisasContext *s, DisasOps *o)
>   static DisasJumpType op_cksm(DisasContext *s, DisasOps *o)
>   {
>       int r2 = get_field(s, r2);
> -    TCGv_i128 pair = tcg_temp_new_i128();
> -    TCGv_i64 len = tcg_temp_new_i64();
> +    TCGv_i128 pair;
> +    TCGv_i64 len;
> +
> +    if (r2 & 1) {
> +        gen_program_exception(s, PGM_SPECIFICATION);
> +        return DISAS_NORETURN;
> +    }
>   
> +    pair = tcg_temp_new_i128();
>       gen_helper_cksm(pair, cpu_env, o->in1, o->in2, regs[r2 + 1]);
>       set_cc_static(s);
> +    len = tcg_temp_new_i64();
>       tcg_gen_extr_i128_i64(o->out, len, pair);
>   
>       tcg_gen_add_i64(regs[r2], regs[r2], len);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


