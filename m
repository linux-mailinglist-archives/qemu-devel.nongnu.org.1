Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CB07DCEA5
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:06:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpNc-000490-IU; Tue, 31 Oct 2023 10:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxpNV-00045J-Ak
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:05:58 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxpNT-0002uD-PY
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:05:57 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c51388ccebso79535231fa.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698761152; x=1699365952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UL7zP/wNaTdy7yDKTxDGR5Mn/76KccS/EQ2Eb8zCbnQ=;
 b=rpNIif7nlRDYtBd2vzciVC4hyGKMV+u4X76mDUslICEJJ0FXEo3JXIx8QwzDQx+6hO
 o+wRB/KDbNkhMKKk0z2KN2RAs44q9CZ/RPWOGiJsmey2TVhHFWHSBcvn3r//7CP9pPb2
 QU8qBlVE6KV2QMIEo6CA5HkRdAing//hwMV+wwYDCkzohy/KTMfOwuXs+JcL6cyE1CjR
 zY6vSqcwOLZ5KAxe2HpO1s3E14TqIidRTeJjzikb3OU94zFdRqHAxve7CTkQV9KxZ/rv
 mVSX9PZsvBeC5n5A2ubVhl9LwOPkAkQLI7WwbwjwxBkqGBbJ6ftu3vFCPD3aoMeifhKg
 auTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698761152; x=1699365952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UL7zP/wNaTdy7yDKTxDGR5Mn/76KccS/EQ2Eb8zCbnQ=;
 b=vFYqKHKcBAKB9XqKqHNzV7ZPltc4QJvZ9EXSrfEJTgl3N3FJ/54/BnwiQYgWV7OP/H
 R//go1bAV3gj0iJ9KGuzfwgheNGl89rWUlR1aVUvQEoBoAklf2vUPq+qCzYSjk+uI1So
 LqnNjaE0oOpOY7ntRSlZj58Mbn2GOgU5SSCuImArmgrViMatwBNkbJZ3LjRtMb50AW2q
 tmwGBSNxibWzoai9EKNC324Xy9T2/CJHNg586bPK36c8JKz8TrEruDUQWz54l27vPqEB
 e2NjE4taphZeR4wm6wg4HU1aHkxylED29oQ3Xmo4LkxTk963qWhlnU5Y5QCTGKnw0YUH
 O32g==
X-Gm-Message-State: AOJu0Yy8a2LTpB4uSSO/SP7+wYUThjIwNrv0qEwz657REJIvOGlpt7wb
 st7v6xPpVqx6QUwFlm7nSsZd1fKSQnG49uNPubo=
X-Google-Smtp-Source: AGHT+IHO41wdQplnRcgg1UVO+6rGIe+1sNObNZxKwDSTO/PNDH1BqSBMWm6uWKPLlSdttLEA7Relng==
X-Received: by 2002:a2e:731a:0:b0:2c5:6d8:8dfc with SMTP id
 o26-20020a2e731a000000b002c506d88dfcmr9381294ljc.13.1698761152405; 
 Tue, 31 Oct 2023 07:05:52 -0700 (PDT)
Received: from [192.168.69.115] (gjh33-h01-176-171-208-14.dsl.sta.abo.bbox.fr.
 [176.171.208.14]) by smtp.gmail.com with ESMTPSA id
 dl19-20020a05600c669300b004080f0376a0sm1789889wmb.42.2023.10.31.07.05.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 07:05:52 -0700 (PDT)
Message-ID: <3e33fbb3-b42f-b525-f987-ccd6e8dcba33@linaro.org>
Date: Tue, 31 Oct 2023 15:05:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/7] qga: Improve guest-exec-status error message
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, dave@treblig.org,
 jasowang@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 mst@redhat.com, david@redhat.com, kraxel@redhat.com,
 marcandre.lureau@redhat.com, qemu-ppc@nongnu.org
References: <20231031111059.3407803-1-armbru@redhat.com>
 <20231031111059.3407803-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231031111059.3407803-4-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.053,
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

On 31/10/23 12:10, Markus Armbruster wrote:
> When the PID passed to guest-exec-status does not exist, we report
> 
>      "Invalid parameter 'pid'"
> 
> Improve this to
> 
>      "PID 1234 does not exist"
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qga/commands.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


