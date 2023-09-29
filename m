Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D29C47B3427
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:04:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmE5c-0002xz-VV; Fri, 29 Sep 2023 10:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qmE5a-0002rX-Kf
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:03:31 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qmE5Y-0001If-2V
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:03:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40651a726acso19478375e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695996206; x=1696601006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TW9vRe0DvsAYN8+Oj197jR8nNJeNE1+wzheFVDXP5nM=;
 b=eWK++r18gL/Q+QOyJoHtvemOm+H8gSIV24aNB1UaGlZdln1kEDJU70w94WHvGgXVlb
 ie30mlUALLwrznmRyqksmWbjFljyRny4TmQSrfmxJzbyJoa0RfDQug2olbyLrN95G5S4
 tR5tvlyd0UHzaY8aDwibe5WkIS/F3RrAo9adCO2kmyxcHw6kI8HtG9rjoCpkvOWz0gQ0
 ZsxtK0FbLuIHYTdhiC6qgig/IzkYXg2UkN0X3ZXLrxF2zUSuV33OjtiwZ4D9UW8hgzlg
 vD2gbt2mZTzQDKxQbvb6p8JqQfYYJ+NO/pwV+6PLPiPF6pZ47+b1Vc6DXb+VD/n2Fdf8
 7IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695996206; x=1696601006;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TW9vRe0DvsAYN8+Oj197jR8nNJeNE1+wzheFVDXP5nM=;
 b=GhWls/q/Chnu0xAnCcFSkwhsHjcC68RaP8Oc1MV0yly04xVoGE76kZkJZ8jFr3EATH
 0VC47xaXggk7wPQ94t7ENzsbFEz66KQDNx7ZPueZiGd+GDKRstlsdMpEYkJogUHB+Kdc
 3hAB14+imlHWrfSU/lOgxuP1+NMgXWDhmkfOznayfwolLUIEn6yDTZT47NNlwM3U02Fd
 Hr/g/bQimc9Mc9k5ObYZJqPqC58CHgEUTcj0TeFuIYOzqNEAq1UeRedzvySKpabUJqfh
 79z2ktbLiTHOYhKcQ8aEtv93sJutineDAnEdgQNXfik0UaG8OivD8b8awo1g/6YdBef1
 v+vQ==
X-Gm-Message-State: AOJu0Yy68mDDdexR4TXVNB+YFxQIMMDSz8xFwH026GiS+dFkbiocZT5m
 w7TzW/P+cUO+SM3Eq+yCSW6koQ==
X-Google-Smtp-Source: AGHT+IFvzbJYOPyT25yop03YhuZJ2IedAcBLrtKupYdoZN1gJEN677Bqd4Oev3Of9PdKGzpiWgLgGA==
X-Received: by 2002:a1c:4c09:0:b0:401:38dc:891c with SMTP id
 z9-20020a1c4c09000000b0040138dc891cmr3672373wmf.5.1695996205217; 
 Fri, 29 Sep 2023 07:03:25 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 bo12-20020a056000068c00b00323287186b2sm12683094wrb.29.2023.09.29.07.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 07:03:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6C3811FFBB;
 Fri, 29 Sep 2023 15:03:24 +0100 (BST)
References: <20230929124304.13672-1-salil.mehta@huawei.com>
 <20230929124304.13672-3-salil.mehta@huawei.com>
User-agent: mu4e 1.11.20; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 linuxarm@huawei.com
Subject: Re: [PATCH 2/9] hw/acpi: Move CPU ctrl-dev MMIO region len macro to
 common header file
Date: Fri, 29 Sep 2023 15:03:20 +0100
In-reply-to: <20230929124304.13672-3-salil.mehta@huawei.com>
Message-ID: <8734yxoz4j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Salil Mehta <salil.mehta@huawei.com> writes:

> CPU ctrl-dev MMIO region length could be used in ACPI GED and various oth=
er
> architecture specific places. Move ACPI_CPU_HOTPLUG_REG_LEN macro to more
> appropriate common header file.
>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

