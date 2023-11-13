Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2327E9B4D
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 12:41:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2VJ2-0005EG-BY; Mon, 13 Nov 2023 06:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r2VIl-0005BU-RI
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:40:25 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r2VIj-0007Rh-SE
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:40:23 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32f78dcf036so3139493f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 03:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699875619; x=1700480419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6VuSOF4f6PSReWUAP/PmTX0cI+28Xi698S58SClcNjM=;
 b=CF61qa2/RsIp1O2VfAXDh/vceYoN54mbIoMzv+YeDuFRh4XQqFNLtltPCONgTpsRbe
 DXNKdtd29upRk11A+jOZt8jYN7I9laeUVYXpHc3AGLgEyJ3iWld+WaStWa0NZnc8bWwF
 NoYX0PuuGsx9MtllInUlYTJnvEjheh0tfXfApV9DC+g/Um8piVqa6FDflZEpcEhgswVz
 uKpi9n70k7RMGbfHBQOTs4eoEzYhRlycn4voTAxFi9fN8rTOBRLajfWXed4DVYAD32V5
 yuf0NKf2wai9DaLdIfldoG/q+T+einPj7YnmoFBLsCZQ6LpVgZE4u5vuPJly98D0TZNs
 tEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699875619; x=1700480419;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6VuSOF4f6PSReWUAP/PmTX0cI+28Xi698S58SClcNjM=;
 b=JXQ/4bckyuOSHo12ZPBLNiCMOPjFfhONbn1TRMljcm/GriehW/GCFB7Bbs5cTGX8F3
 68IptJoTouFzjGE2cmbfy50HJWDdr/3R5vrqivWg9j9V5IEJwEWQVuqQYMbSlDWBKUEg
 cOGk5t98LVmI2PN3EjJalgHcDASScLUMV1ib5rSrPFbYvUhAv+kRjTJtogN+xnNMu/ej
 /jQ9AFbFy9n1gqOrIwhs8nuLsVs/r0SPnsqBaeBFjEV13G2bVFfd8Df5MjeWcg5rfGgB
 yrdaAV7Avm0Uba10bk6+Rk8ujbwUDd6E6fIHT9cclcSrpbaJXwTU4yZZSHn6YHpBfmH+
 CG8A==
X-Gm-Message-State: AOJu0Yyxv6BMc126PnI7FyurZepkyWI91TGKqxiyr6/BenwE5GCQAU7r
 5GZhwc1BSA81QJIYyLKY9DPrlw==
X-Google-Smtp-Source: AGHT+IFe6tOc6XX1ZZrwcHArC2O8mTidUUcpuyVSBz2fz4ahh3JcHzGaE260CERqzhRWmO7TZEY9kg==
X-Received: by 2002:a05:6000:1565:b0:32f:b47c:f1f6 with SMTP id
 5-20020a056000156500b0032fb47cf1f6mr7831895wrz.32.1699875619566; 
 Mon, 13 Nov 2023 03:40:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l11-20020a5d526b000000b0031c52e81490sm5237713wrc.72.2023.11.13.03.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 03:40:19 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DDD0C5F787;
 Mon, 13 Nov 2023 11:40:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Alexandre Iooss
 <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [PULL 21/38] plugins: update lockstep to use g_memdup2
In-Reply-To: <91b491ca-5600-4272-b694-37d6c8ba2a90@redhat.com> (Thomas Huth's
 message of "Mon, 13 Nov 2023 11:46:56 +0100")
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
 <20230703134427.1389440-22-alex.bennee@linaro.org>
 <91b491ca-5600-4272-b694-37d6c8ba2a90@redhat.com>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Mon, 13 Nov 2023 11:40:18 +0000
Message-ID: <87r0ktyj8d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 03/07/2023 15.44, Alex Benn=C3=A9e wrote:
>> The old g_memdup is deprecated, use the replacement.
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20230630180423.558337-22-alex.bennee@linaro.org>
>> diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
>> index e36f0b9562..3614c3564c 100644
>> --- a/contrib/plugins/lockstep.c
>> +++ b/contrib/plugins/lockstep.c
>> @@ -130,7 +130,7 @@ static void report_divergance(ExecState *us, ExecSta=
te *them)
>>           }
>>       }
>>       divergence_log =3D g_slist_prepend(divergence_log,
>> -                                     g_memdup(&divrec, sizeof(divrec)));
>> +                                     g_memdup2(&divrec, sizeof(divrec))=
);
>>         /* Output short log entry of going out of sync... */
>>       if (verbose || divrec.distance =3D=3D 1 || diverged) {
>
> FYI, this seems to trigger a compiler warning on Ubuntu 20.04:
>
> https://app.travis-ci.com/github/huth/qemu/jobs/613144955#L1914

Isn't 20.04 outside of our support range now? Otherwise we could add a
helper to glib-compat.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

