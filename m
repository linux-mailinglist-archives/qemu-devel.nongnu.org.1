Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8045D78D6C7
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:01:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMgv-0004DW-HE; Wed, 30 Aug 2023 11:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMgt-0004D3-Un
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:01:07 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMgq-0002TP-1u
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:01:07 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31781e15a0cso5054017f8f.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407662; x=1694012462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FOg8ihkf6ELEG0+P8qNh0Gi4lsiRRUWL+RyiTWoniz8=;
 b=Q1W4qo+AKkAYLr8Wsgy1DrN147Ox+ezmxMxnlE0/JfnNfuEIQLQPE8c4g0tx8m6JRh
 +dKAF3cNHiB5DMEwVt8/gIpz1J8OMVIF6DIHG+r9PoAKsHBpJppdtWrrw8Dhb8uJlJ7y
 gjYunGGqz6JxvV39RPZeN6hEczDeJ0zEUXMrtzZvuGC7/hJCopfx/B9ViynTHsOj0qRo
 aabhDnam96b/GoJwvU3ZWJv3ZNycRlf+Yy1EMER1ZwySLdqdzW/kd5az9MqTib8GXs4j
 auL+wYoPu09R2m7YHW9l1jt++peWJAfzirII4Rt6LVwhp7qI+RG6kvdebZZ9WzPvmsMS
 +iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407662; x=1694012462;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FOg8ihkf6ELEG0+P8qNh0Gi4lsiRRUWL+RyiTWoniz8=;
 b=OSIYmOGq419ED9wj7qHLWhLBoV24aa4gb6h7Gqf7prFzcHy4VrhU01DFX1roYi5GzT
 6aKCq+32yMhWwncv9f5aVF7HrMcUSzs8kqpsfpz1mOQ0lRx27zVcizEYVLID77EoA12g
 Imu8WMvckBLNp2Us+N8OaoN3h8aRTgds58B8yY1HoNDExqHqmxpAPyG53W9zyXeEWfmP
 O6E9Z8VHgic5sz/XBInUtoFtvpM4jLMHXtZiTE5/sLTsdr0SdIGnjbmkolE+wCqeI+rP
 0M/Y1xq+h+Vw1N+xP6veuzSrbSEeRrZf60yzhkAPz0vK3LLdkIX1CyleD+he/e82jBts
 8PHg==
X-Gm-Message-State: AOJu0Yw6AkBDemuIWXYLqXHX12RzcYonk7HTkrhj/bS3DTMZcPVavyE3
 5VMXecczB/FjQmVsbmAVNWnNLg==
X-Google-Smtp-Source: AGHT+IHn4Os2d5uK5qlww1lMQFBLvf1l2sMer12tv4guIgRSoRtYy7TJalOIPk+IKvgN6xd0WpZX+A==
X-Received: by 2002:a05:6000:114e:b0:31c:804b:5ec3 with SMTP id
 d14-20020a056000114e00b0031c804b5ec3mr1770108wrx.67.1693407662063; 
 Wed, 30 Aug 2023 08:01:02 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j14-20020adfea4e000000b003142ea7a661sm16947763wrn.21.2023.08.30.08.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 08:01:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5165E1FFBB;
 Wed, 30 Aug 2023 16:01:01 +0100 (BST)
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
 <20230818033648.8326-14-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, Song
 Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater
 <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz
 <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin
 Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, Liu
 Zhiwei <zhiwei_liu@linux.alibaba.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Bastian
 Koppelmann <kbastian@mail.uni-paderborn.de>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>, "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, "open list:S390 TCG
 CPUs" <qemu-s390x@nongnu.org>
Subject: Re: [PATCH RESEND v5 13/26] hw/core/cpu: Return static value with
 gdb_arch_name()
Date: Wed, 30 Aug 2023 16:00:56 +0100
In-reply-to: <20230818033648.8326-14-akihiko.odaki@daynix.com>
Message-ID: <87r0nkr2vm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> All implementations of gdb_arch_name() returns dynamic duplicates of
> static strings. It's also unlikely that there will be an implementation
> of gdb_arch_name() that returns a truly dynamic value due to the nature
> of the function returning a well-known identifiers. Qualify the value
> gdb_arch_name() with const and make all of its implementations return
> static strings.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

