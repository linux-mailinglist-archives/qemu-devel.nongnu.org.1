Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF4F7DD86A
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 23:37:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxxMH-0002KT-AR; Tue, 31 Oct 2023 18:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxxMF-0002KJ-VQ
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:37:11 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxxME-0002UF-2B
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:37:11 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32dd70c5401so3926379f8f.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 15:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698791827; x=1699396627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/TBBNVA05JCkPeNdf3ra+2Jr+pGDtPsDwSB8Psubwro=;
 b=rW/B47imGhE0e5j3/9MMkhqF9bzNxWFhxR/xwY4diSi39D3BBcszkE2Wn0w1R0Z+n9
 JaT6dCX/Jmcz/tTqT/L7HPKk19eBhlSr2M9YidAflpbxr15DuJb0O4YMV6UbI1wCotXM
 0Dajz84CXg7k8e+DuK7RjS1chcp4ZdTqi/8g7rAfLeo4fY7vDHCrjGXWhHVSpNrgkMjw
 CS03sFzI0/YK9bruo9ZkhyoFMoUyZD1qjhv4oCnLBRyb2wMsCjXWZIgEG3OHfL2FFnjJ
 LVdZdu94/wk4ERF1ZqKTprV6I+icnISL+b/UDZIN+BwZMr4AbOs8U17tvUkV60En8Lzx
 G0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698791827; x=1699396627;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/TBBNVA05JCkPeNdf3ra+2Jr+pGDtPsDwSB8Psubwro=;
 b=OJjIZUMaV+eSKhXmOIe7XcxASekSqSU+R5FObhoimd+Ra07CQckTQDSnC88fPMe2oP
 PyAk9cXnRNOB8wwGQ1KdyjhtkwOvAjdo9zEi/zFE9zaZcInNDcpVW/eKPhWdIR+hvPDx
 Dkv+mAJZKAssDbKYXwnsKO1DGiI1vxChkAggliHaK22hmdpCk2jrpp1MtoNqKMgZIfuG
 UJVF65paJp5ZoXNT7qz4CLfNU16hlJJ2zPekA51bfumazioCF/0FR2jJ8JWI3/jVBNF7
 GWJpBJIzbz98/IWnzkcDPU5g1HSLxghOqi70e/0jNF2MzDv2BMfsEx+V1tkSkaRSRb3Y
 Sepg==
X-Gm-Message-State: AOJu0YxDhF4BVe4uC4BKkL5wqFRuWXjxhnl6gUr+qp1DmehVi6dnDLdt
 848+0sxBhbvaKV4ik/pRHQemhg==
X-Google-Smtp-Source: AGHT+IHGyuxFaIXjrE78L4QiVrtzrM+IlOOEELvcPffLyiTc9TJZ56g/rpldMRw3UpBtnOqD9PtCHQ==
X-Received: by 2002:a5d:5109:0:b0:32d:e6ec:2862 with SMTP id
 s9-20020a5d5109000000b0032de6ec2862mr9725167wrt.7.1698791826916; 
 Tue, 31 Oct 2023 15:37:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u15-20020adfed4f000000b0032d9548240fsm2482942wro.82.2023.10.31.15.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 15:37:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 077CA65724;
 Tue, 31 Oct 2023 22:37:06 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?us-ascii?Q?=3D=3FUTF-8=3FQ=3FPhilippe=5FMathieu-Daud=3Dc3=3Da9=3F=3D?=
 <philmd@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,   Mikhail Tyutin
 <m.tyutin@yadro.com>,   Aleksandr Anenkov <a.anenkov@yadro.com>,
 qemu-devel@nongnu.org,   Fabiano Rosas <farosas@suse.de>,   Laurent
 Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v6 5/5] default-configs: Add TARGET_XML_FILES definition
In-Reply-To: <96d26981-a0e7-fdfa-844e-18ddabba79cf@linaro.org> (UTF's message
 of "Mon, 30 Oct 2023 09:47:29 +0100")
References: <20231030054834.39145-1-akihiko.odaki@daynix.com>
 <20231030054834.39145-6-akihiko.odaki@daynix.com>
 <96d26981-a0e7-fdfa-844e-18ddabba79cf@linaro.org>
User-Agent: mu4e 1.11.23; emacs 29.1
Date: Tue, 31 Oct 2023 22:37:05 +0000
Message-ID: <87bkceh10u.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 30/10/23 06:46, Akihiko Odaki wrote:
>> loongarch64-linux-user has references to XML files so include them.
>> Fixes: d32688ecdb ("default-configs: Add loongarch linux-user
>> support")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   configs/targets/loongarch64-linux-user.mak | 1 +
>>   1 file changed, 1 insertion(+)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

