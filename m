Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA6B7880EC
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:35:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZRLS-0002sH-AC; Fri, 25 Aug 2023 03:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZRLP-0002ra-Iz
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:34:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZRLL-000637-P4
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:34:59 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fed963273cso10374755e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 00:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692948894; x=1693553694;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=84GmhXOl7P6Tk7mMSWYjKLpOgRyG/IkgrywMEq0AuUk=;
 b=fnZYXJFZ+iZzT0pD9y4Y5AxeQTDLt4kaiq2r0Li4pODObGYa8CBnHYmbEnuspCfuN8
 ZEAPoZ7rt6Fbi+JWP2e2n1jEU/RrIBwAkLmY+6tPGpOD2erhdxCAXblB5KaS2NNDXM0O
 4u4jyZGF+U8BJGXH66GQLx44wz/E8eAdxJwPAho0++c7JpsKuw2tluXGvF6i8eLangrD
 OkNCxJ6TKAkey+RFRDMmod9ZkYO5AIUX5QQyb4hnfYlBtUkhjuF4hgEvvheAd1bZq+I6
 5VLvZNZZKefhtlbkO50D5W8A6ccOGAVzlZ4pN8pI/tPE6drzu5F+C3sZIsF3p6Gfpr4w
 QbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692948894; x=1693553694;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=84GmhXOl7P6Tk7mMSWYjKLpOgRyG/IkgrywMEq0AuUk=;
 b=G20vr0wgGOMBW2UL/5jXRsDxaD3JaKphxtUC2vEX22imBmf8wgtH6riOWWmLPzMcrG
 lwuIXY8lPoEcq5jbJPLv/euqymG4iC/EnnqG5zKmVXBnY3Fc0YqsBcCTyRQuCVmr//NM
 d1uDqZibbXcZhh0PK+ASgN7i2/X8WVDihRPqnETnAxe1/su7/rNf8cRkydEVce+cjt23
 stTWVZifWI4Rk2xO/DdRD+gsngU46r26IrjNTG2VwVx+tehLdOKFklcNiPKLdz4aUJq8
 AZ/oOqRaB17t1h0rmIpzKvoUPGkOw2fv4UQl6+80uiMtRTtY1cYVKWbjOWZVplJCDokN
 QERg==
X-Gm-Message-State: AOJu0YxGXRZbTsN6HssUkVwH8tDiW9/xqhD8FIJqop2YaRnRb1MhoXuw
 XNc9OHCKkaXpIHsw0rnfLNTtuw==
X-Google-Smtp-Source: AGHT+IHJQWvqtmIX6rw9zSWT7Mz7ZWbY0SwY0jn6OhQVKUY6bqD7Q3h1UVv4qxsdl9fRAbdh4KRdag==
X-Received: by 2002:a5d:4950:0:b0:314:314e:fdda with SMTP id
 r16-20020a5d4950000000b00314314efddamr14952323wrs.23.1692948894034; 
 Fri, 25 Aug 2023 00:34:54 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4205000000b00317ddccb0d1sm1392619wrq.24.2023.08.25.00.34.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 00:34:52 -0700 (PDT)
Message-ID: <02012ce4-db06-cacc-6e70-f5bd3108362e@linaro.org>
Date: Fri, 25 Aug 2023 09:34:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 12/12] gdbstub: move comment for
 gdb_register_coprocessor
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-arm@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
 <20230824163910.1737079-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824163910.1737079-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 24/8/23 18:39, Alex Bennée wrote:
> Use proper kdoc style comments for this API function.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/exec/gdbstub.h | 10 ++++++++++
>   gdbstub/gdbstub.c      |  6 ------
>   2 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


