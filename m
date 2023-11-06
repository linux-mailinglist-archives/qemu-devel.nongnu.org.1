Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 092E67E28F5
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:46:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01ls-0000Sy-I6; Mon, 06 Nov 2023 10:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r01lq-0000SV-Oc
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:44:10 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r01lp-0006Zc-5V
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:44:10 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32daeed7771so2399494f8f.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699285447; x=1699890247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMvLvxGprVQjVMaAYN+UHIBUwMb0j0gOsjRtE25fg8w=;
 b=UOOc921H0/0SpKDvURKH2CXbAR0E+8SJCE2ETQ8JZJ3CNLJYb9O12pNFJm0xqzvGCr
 +RGE7Suk2KQdD3mMSO5Xnuken1+zp1KwoAfT1uOchHrWWBAUZGmC0/Bf27fDAUuXS7Yh
 DNilC3R+f6p9JkZc1r81jfJUCNFuhweS1WyVYyK4jhQq/spiDaZFqB9+jvYFS5Czpam+
 c3lrG3hZzegghvXD8hpndLL10fRnotS2vt1wARkcM+uEt58TyB94fvVL3EnM85zhaLCJ
 Cg/umxbWLlngbbE8lacsE8ZPjmnOi6e7uId+7nqGWqgUvrRV7kuRezNj13MfE77XBwFF
 fPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699285447; x=1699890247;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WMvLvxGprVQjVMaAYN+UHIBUwMb0j0gOsjRtE25fg8w=;
 b=o/ixqQfjVqGIHr7egQqxYb5U0XfAbkoWMLyHle2iHActwiOc9p+9I68X4O/gKpzbtq
 kjEpGykPyUTkQqm/T6cEqIiEkcGfx0jtlZFLKYUV8gwQt0GmUOATCKIwID+xs/gnXKFJ
 dM9qTLl10oxfWR9NBtKTYzabHfMRcT94dCQXPBdA1rOIoq3XlBU6XSfuOCF1LlMUQ7hd
 l2Y61jyj8+QVCyAEyItCFMP6ARPq8H6+a6VmhXn9yea3flWTEbRhWCt3JiDjYeiuVHjc
 p5WiLnuwM9apV3olaotsHZbfe5Aq4ImklzyCei+awhBKEL4maTZ7oR7pKZQZXY5OH46t
 cvBg==
X-Gm-Message-State: AOJu0Yw2yAqhj2GlnACM3H6EfLpQgSRI50VyBtfxmdbdtxqPVhOC0Uob
 HdIRji9MJC5JR14jNZSHet1WVw==
X-Google-Smtp-Source: AGHT+IFqINJy6jrHXRbJYthBvctxKO1ifh6Qv2IgMJ3k9HS3Y3IkNirqWmPVAbOsmhKzBpiti0fOew==
X-Received: by 2002:a5d:4390:0:b0:32d:81b5:82d0 with SMTP id
 i16-20020a5d4390000000b0032d81b582d0mr19600278wrq.33.1699285447164; 
 Mon, 06 Nov 2023 07:44:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d18-20020adfa352000000b0032fb9c5aa24sm9256015wrb.93.2023.11.06.07.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:44:06 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 657475F79F;
 Mon,  6 Nov 2023 15:44:06 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Song Gao <gaosong@loongson.cn>
Subject: Re: [PATCH 01/29] default-configs: Add TARGET_XML_FILES definition
In-Reply-To: <936a0e12-f022-4d16-a21c-89e4b77f547f@linaro.org> (Richard
 Henderson's message of "Sun, 5 Nov 2023 12:55:25 -0800 (18 hours, 48
 minutes, 6 seconds ago)")
References: <20231103195956.1998255-1-alex.bennee@linaro.org>
 <20231103195956.1998255-2-alex.bennee@linaro.org>
 <936a0e12-f022-4d16-a21c-89e4b77f547f@linaro.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Mon, 06 Nov 2023 15:44:06 +0000
Message-ID: <87zfzqc2ex.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 11/3/23 12:59, Alex Benn=C3=A9e wrote:
>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>> loongarch64-linux-user has references to XML files so include them.
>> Fixes: d32688ecdb ("default-configs: Add loongarch linux-user
>> support")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Message-Id: <20231030054834.39145-6-akihiko.odaki@daynix.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>>   configs/targets/loongarch64-linux-user.mak | 1 +
>>   1 file changed, 1 insertion(+)
>> diff --git a/configs/targets/loongarch64-linux-user.mak
>> b/configs/targets/loongarch64-linux-user.mak
>> index 7d1b964020..43b8a2160f 100644
>> --- a/configs/targets/loongarch64-linux-user.mak
>> +++ b/configs/targets/loongarch64-linux-user.mak
>> @@ -1,3 +1,4 @@
>>   # Default configuration for loongarch64-linux-user
>>   TARGET_ARCH=3Dloongarch64
>>   TARGET_BASE_ARCH=3Dloongarch
>> +TARGET_XML_FILES=3Dgdb-xml/loongarch-base32.xml gdb-xml/loongarch-base6=
4.xml gdb-xml/loongarch-fpu.xml
>
>
> The qemu-loongarch64 binary emulates loongarch64 only, not
> loongarch32.  The inclusion of loongarch-base32.xml here is not
> relevant.

Does the system binary emulate both?

> That said, we don't exclude TYPE_LOONGARCH32_CPU or -cpu la132 from
> CONFIG_USER_ONLY, which is a separate mistake.

Where should that be done?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

