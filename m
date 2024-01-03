Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF92823893
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 23:52:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLA5C-00072p-0a; Wed, 03 Jan 2024 17:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rLA5A-00072a-4L
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 17:51:28 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rLA58-0000Kq-FO
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 17:51:27 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6d9bec20980so2987256b3a.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 14:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704322285; x=1704927085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1jZ0RG8uPRr+nSxfmWFv2Fjdv8/aZTEq3n502wIT5kU=;
 b=VjdyPywSDFuIKvhLOrAXS1rJojdNJbWjchdtHXGCcsZFSUdvJxO7KZg7Shlns+uJ8R
 EWdYwRkietnZ3gwdch+mvgDGZTJm2CRyKSBVoIa5gCcAqNChUz1SOWWvmJSkLEvcFC8S
 6JsEIZPlfSGoKs9cNpHU5XhpY/Nqf3W0gHkaWJVASagN8FQgxUekDb6pntp9VZZKMi92
 WUkCi8cp47KcfdJEIVcRQmSfCN6CjWo82/UjpSY/iK80yyT+ydDyd6KGcvxP7TgI3Evn
 ZWNPQOB3SVMrSJ+jamY6RB3k2WxmxkXnkmUhkiblMN0TLFC2wxtPFA14bSNunw1fCHXp
 dE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704322285; x=1704927085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1jZ0RG8uPRr+nSxfmWFv2Fjdv8/aZTEq3n502wIT5kU=;
 b=mDBEBqivV07wH9M0JbhLPGshpvEL6Ec4fIi2Q2QNGNxcdh0gsbDVXVBJ1QoC5Dnhfq
 HS6X3LD8WsW78p/VJl0F1tLa7h7R8J+erxdjt6m0EB81IX1XSJWv7O0CLt4gqCmfHNCi
 zlRBipZzGkmxKdMCximzDYztGF7+I2HBKdSzNcJiY9fy5FF3IXlQ66Ky6Z5aOC37QQfH
 T8mykIDMJvNwxOzdlfLbyIqtW0D6G/n5tr5CCkgMUWQgw+QETjx6j48rV1DX+2GWeQ/s
 uNX2/lvkXKY2ZwscBzzf8WkVnGHyiK2RyssXnQ57FDSnZ4+fPAtEDbop8c0omFIbrYpw
 wU0w==
X-Gm-Message-State: AOJu0Yxl+zt6uS5AG4DhRD6WSu9JPxbjF2cSZLeAqVufIECowXtLaqT5
 aYG7lbPFHPAkukz7MKm0YQ1MP31fGOHPpg==
X-Google-Smtp-Source: AGHT+IEkO6LDDOR8aR7vWzj+3anpFpuXqiiLDKr2FNML0EPZb3duGDui0sV25f8FSfxd2lw95gjxfA==
X-Received: by 2002:a05:6a20:7411:b0:197:5779:4d29 with SMTP id
 n17-20020a056a20741100b0019757794d29mr1758246pzd.25.1704322284697; 
 Wed, 03 Jan 2024 14:51:24 -0800 (PST)
Received: from [192.168.50.95] (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a170902e5c100b001cf658f20ecsm24155217plf.96.2024.01.03.14.51.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 14:51:24 -0800 (PST)
Message-ID: <5c3098cc-3a2f-4272-b06a-6d12d645d628@linaro.org>
Date: Thu, 4 Jan 2024 09:51:19 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: chacha20-s390 broken in 8.2.0 in TCG on s390x
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>
References: <d5e8f88b-1d19-4e00-8dc2-b20e0cd34931@tls.msk.ru>
 <dfc5987a-4210-4579-b9a3-1cc12fe1b909@linaro.org>
 <cc4ad254-b177-4a09-96f7-448c638ae67e@tls.msk.ru>
 <f07dfa5c-9f3c-4e22-9514-81c130b6a9ab@linaro.org>
 <764215cd-6f62-4746-b1f5-6174a158f95d@linaro.org>
 <e1f48ff4-d640-4500-9f2b-6b9db0d8ffe3@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e1f48ff4-d640-4500-9f2b-6b9db0d8ffe3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/4/24 01:37, Philippe Mathieu-Daudé wrote:
> Finally changing the constraints on op_rotli_vec seems to fix it:
> 
> ---
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index fbee43d3b0..b3456fe857 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -3264,13 +3264,13 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
>       case INDEX_op_ld_vec:
>       case INDEX_op_dupm_vec:
> +    case INDEX_op_rotli_vec:
>           return C_O1_I1(v, r);
>       case INDEX_op_dup_vec:
>           return C_O1_I1(v, vr);
>       case INDEX_op_abs_vec:
>       case INDEX_op_neg_vec:
>       case INDEX_op_not_vec:
> -    case INDEX_op_rotli_vec:
>       case INDEX_op_sari_vec:
>       case INDEX_op_shli_vec:
>       case INDEX_op_shri_vec:
>       case INDEX_op_s390_vuph_vec:
>       case INDEX_op_s390_vupl_vec:
>           return C_O1_I1(v, v);

Definitely not correct, since VERLL requires a vector input to be rotated.

> But I'm outside of my comfort zone so not really sure what I'm doing...
> (I was inspired by the "the instruction verll only allows immediates up
> to 32 bits." comment from
> https://www.mail-archive.com/gcc-patches@gcc.gnu.org/msg317099.html)

That message is confused.  The immediate in VERLL is 12 bits (with only 6 bits ever used 
for MO_64).  Dunno where "32 bits" comes from.


r~

