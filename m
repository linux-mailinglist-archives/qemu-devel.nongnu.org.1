Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3039B4311
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Oct 2024 08:25:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5gaN-0000fu-1m; Tue, 29 Oct 2024 03:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5gaL-0000fm-4z
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 03:24:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5gaJ-00070U-8E
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 03:24:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4315e62afe0so53266275e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 00:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730186648; x=1730791448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1PCgOxrC43jSKVDpYjFge8nsRfLdgayd3aGo9rH+euo=;
 b=nkckw0ORvYRL0QbheO6IvmMGHjSmILOYpv32GbEAmNAooK3nsfshvSzrYowZZerLff
 Bk0SgH3e+uhI27cv1YkbukQxLge548Qkzq3ExmH0DdRX/oM+xhG1giPAOVVdopGYwCBz
 +rSGWg+N+sEeiYpOTG2tBosBJnvdiLtfUEpVvykWqV+7/Qzx/rRgxgUdsUcL8J1cm7w8
 ozhs48cF9Xxs7EZPKiBy0PdKGbd/UcPcFgf6L9HHE4lVq/paIjC87Sa2wuQk7EKjwwBD
 YxtR7W8fECIqVHZkDt88lRusaUb1eFDrU5y8ZhYDD2rEPaEsgHqpOZjA61fmqXy8Ngh8
 nXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730186648; x=1730791448;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1PCgOxrC43jSKVDpYjFge8nsRfLdgayd3aGo9rH+euo=;
 b=LzCtVuvZueOp1nVp6g31U4w8K93lip1At/1GMLSKscwleve9d1GUOv8ITBqlhDz3ig
 25kzpaunUBpWx0vQqMmq10cxKrALXIjx+k1DzXwwr5JUjgnkxywXq1GWCBX0RYDW7qHq
 gGa8blXWLhZcXmnTqSsLymaJOcMteVhL9Da/9ZiXORYPs3qUCA4G4benHGPjnfgIqOM2
 F9Y8d8+YHX+yBpPV1sIhIECwb5NuWHdoK9L+qFXGJIvJ6ljw4orR+nCCCbBOOQGKthgL
 pH3Ph0EIb7CBl+Tsyo61/dTJXlHzqURhnJO94GAuwe9nwjV1X02xy6tVIKLX6yPVaqt2
 XlJQ==
X-Gm-Message-State: AOJu0Yx5KVNiMulykA5pBC6PFqbisDHm548z7SYvCxrd0Nwf8TIO3R84
 KIMfTECuSMRNr9uCC8BT7B87eSxlUaXSyu9uMt4YkG8fG3n0jjJ/5YpV8jZDrrM=
X-Google-Smtp-Source: AGHT+IGZc9x3Wq/FkNVyMpYPmnc0A5t/2NcMt1EzERXcGj6Nzd2mn5DE/Qa8RwmBPUvqZjL3xMqArA==
X-Received: by 2002:a05:600c:4f4a:b0:42c:b9c8:2bb0 with SMTP id
 5b1f17b1804b1-4319ac70637mr81747055e9.4.1730186648376; 
 Tue, 29 Oct 2024 00:24:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b928cesm11704556f8f.102.2024.10.29.00.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 00:24:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D91955F796;
 Tue, 29 Oct 2024 07:24:06 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>, felipe@nutanix.com, iggy@theiggy.com, Warner
 Losh <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe
 <jgg@nvidia.com>, jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Max Chou <max.chou@sifive.com>, Mark
 Burton <mburton@qti.qualcomm.com>, mdean@redhat.com,
 mimu@linux.vnet.ibm.com, Paul Walmsley <paul.walmsley@sifive.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Bernhard
 Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas
 Huth <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: QEMU/KVM Community Call (29/10/24) agenda items?
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 29 Oct 2024 07:24:06 +0000
Message-ID: <87bjz38j8p.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Hi,

After a missing a few weeks due to travel and conferences the KVM/QEMU
community call is at:

https://meet.jit.si/kvmcallmeeting
@
29/10/2024 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

