Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 428D4725699
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 09:57:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6o1s-0002dq-Ni; Wed, 07 Jun 2023 03:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6o1r-0002dZ-Ci
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:56:27 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6o1p-00056E-Q2
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:56:27 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f73617a292so39078385e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 00:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686124584; x=1688716584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AACHmxdl0iM7W3/5W5ceg8UG536JCbQYkoVjsHxxJn4=;
 b=RZ6HBbOrS3BetkS2vXVwzBrHiVESmo/DKBY8QbHZudgQYbuEZljqSqJWlcEZUsqhoG
 EvaQxfk+3dXv+SDPindb7u/wh4DZpi1OH5qgDEuJVBfhx3N7f4BeK5HsIWWAtMTcuIB+
 0/CDvPzuKf6Hw3XbKHHjucwTF0iBpUWTTtVmiSmVX7BCwAL/18p7Y2FUtLz58hL0NVIc
 wnXxmGfbry2DsJa+aN42lpEFFm8h+1tSPUtxDng7d4kW/OOkcOpa9bTycVOSU/ouo6tF
 QCSU91mBFe8wRieFJYYiIpy16E6GSRZbAu8V0e76dg7d84vs9u/s2F3snTpvJTUMltdn
 iOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686124584; x=1688716584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AACHmxdl0iM7W3/5W5ceg8UG536JCbQYkoVjsHxxJn4=;
 b=GrCMgIhaG1Y0j3vpEd6Eug5gufCm8jvRHdEBAP1KG+SFItFqpUZ+iOLPlh8Lao1Cf8
 PSEhMB9ykwLKDKj97AsvMB47zvQEwME/b8oilK5K2LQXM9kq2WVuq+yl7/qPazlvmTIR
 QTvLvheFokSKewpaMJbWueydjPxQyO+0DPaoVOmBaDtWxTo/opoc/+OekmbCXf2ll/Ny
 B3WTENZxzkqoCjnTHRGk1rukwGncaXZMHXro8ltcAJTIaZbwX4WgBy4xo5moSkXJBF4+
 NDPd6KCXf/fX7zdkjffQsrqjCDcMCdB+zBP/0lWaWnLtby0nCcAEky1MK3Mc4TQQd41J
 ksQA==
X-Gm-Message-State: AC+VfDzczjE4kF6Yx/YVO1aR7M3z1xUPcQvibPKPIBCIK078qQF9KeDx
 BOmM7sJurq7GHMqVUs2qgWNhmA==
X-Google-Smtp-Source: ACHHUZ4LI/W9ZHWO294xhZuedt023+/KT2t+jnhy5plOaw1WbwERMndwQUvn8oOsKT9ldAL6b/QRbQ==
X-Received: by 2002:a05:600c:2903:b0:3f7:948f:ad1c with SMTP id
 i3-20020a05600c290300b003f7948fad1cmr3838926wmd.6.1686124584209; 
 Wed, 07 Jun 2023 00:56:24 -0700 (PDT)
Received: from [192.168.69.115] (bd137-h02-176-184-46-52.dsl.sta.abo.bbox.fr.
 [176.184.46.52]) by smtp.gmail.com with ESMTPSA id
 n21-20020a7bc5d5000000b003f733c1129fsm1230560wmk.33.2023.06.07.00.56.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 00:56:23 -0700 (PDT)
Message-ID: <af1ca2f6-6b4b-4f28-bd42-93f36d50e5d1@linaro.org>
Date: Wed, 7 Jun 2023 09:56:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 1/3] migration/multifd: Rename threadinfo.c functions
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-2-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230606144551.24367-2-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 16:45, Fabiano Rosas wrote:
> The code in threadinfo.c is only used for the QMP command
> query-migrationthreads. Make it explicit that this is something
> related to QMP.
> 
> The current names are also too generic for a piece of code that
> doesn't affect the migration directly in any way.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   migration/migration.c  | 4 ++--
>   migration/multifd.c    | 4 ++--
>   migration/threadinfo.c | 4 ++--
>   migration/threadinfo.h | 5 ++---
>   4 files changed, 8 insertions(+), 9 deletions(-)


> -MigrationThread *MigrationThreadAdd(const char *name, int thread_id);
> -
> -void MigrationThreadDel(MigrationThread *info);
> +MigrationThread *qmp_migration_threads_add(const char *name, int thread_id);
> +void qmp_migration_threads_remove(MigrationThread *info);

Dropping 'qmp_' prefix:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


