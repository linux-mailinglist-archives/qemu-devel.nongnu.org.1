Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5937AF320
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 20:42:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlCz6-0007Gz-52; Tue, 26 Sep 2023 14:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlCz1-0007Gb-QX
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 14:40:32 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlCyx-0006So-Ud
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 14:40:31 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c3bd829b86so73374915ad.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695753626; x=1696358426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hjy5uEMN2yWslbrhKnIfXD/tPuQarm7f16HNgL4Emj8=;
 b=GprFnMDXTu5URTa3sXZjw3snyh5kLOyKRncdWaawSgC+K/2VCysPILVgoRUNzj1RkT
 IshJKxx/hVoNWf+Le0BPn53LQPVeX/aUu1nT25v3znQUeXNhnCTW1fIvdpPsDBeLOvyv
 sHy1E9kYw/MNKWOaUR4cobY0jGoGAmPlsFpbmGtP8Zte5Y4STF1KIdt7a4rSlfPmNxHR
 Vgd8qC1gBvb/UrmIkszRPHT71PoJvdHO6HReCXVt6DmMvXpy0mbBxDJvaSDChblUW24Z
 LyMdEZKg8wPQRQfVHPTm1wcc3uknvGBKV6vgYvL9Gqb5q+oO3uqPQGh2959Eb3Px4yZo
 WTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695753626; x=1696358426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hjy5uEMN2yWslbrhKnIfXD/tPuQarm7f16HNgL4Emj8=;
 b=Ec1AWOg4SOk+TOKYeFUJqTD0LGUX+NRQps0f3EUDorm9vTDK+8it64iehsCKsuuO7l
 VusszRBFsaukTgdhU1aMW3rgiMuUQRdN0PL0srPZNvkr3QYJ5x0noHZZ1FhxHyVaCoI9
 essaxUWgJAon4ctFrOY7JTGRq8HXkOhvKVeyHN8Nv5EcBG8vWyoIxHSmj/nmbde4G/SG
 EqRMUxr4JZ2IqXZVCmbAzanzbuD0p556X+WxKV4CKkNKrH0bBO3KrqodXqV+Abr7aCKO
 JmIsQKo/9Nd1QDQ8USmuM/vawvuVEShmFSeg2jHUVoNQ7wg9ptA5FBdbKI0K3asRlvMJ
 nx/A==
X-Gm-Message-State: AOJu0Yx8EEliyX5Id4Jck/sqUPOQrs4fbXzQjAA3bF5hZdTw3Rm4AsOs
 bMRMjWDK1yBM6JV0kF3+XRlop97t2fpGJMY61qM=
X-Google-Smtp-Source: AGHT+IE9dfjy44js2v6L2N42TGYt4bGLmRpvkJ98Nvs1Fw1Ecqn3+lKGdsdKMocE6Oi88NYkSBec3g==
X-Received: by 2002:a17:902:e888:b0:1c5:d063:b72a with SMTP id
 w8-20020a170902e88800b001c5d063b72amr10643069plg.27.1695753625822; 
 Tue, 26 Sep 2023 11:40:25 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 a11-20020a170902eccb00b001b9cdf11764sm11268306plh.31.2023.09.26.11.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 11:40:25 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/6] riscv: query-cpu-model-expansion API
Date: Tue, 26 Sep 2023 15:40:13 -0300
Message-ID: <20230926184019.166352-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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

In this second version we stripped patches 1 and 2 from v1. They're now
being treated in separate in=20

"[PATCH 0/2] riscv: add extension properties for all cpus"

Note that we'll need these applied beforehand to see vendor CPU
properties with this new API.

This series implements query-cpu-model-expansion for RISC-V. The
implementation was based on the ARM version of the same API in
target/arm/arm-qmp-cmds.c.

This series can be tested directly using this branch:

https://gitlab.com/danielhb/qemu/-/tree/qmp-cpu-expansion_v2


Here's an usage example. Launch QEMU with "-S" to be able to issue QMP
query commands before the machine starts:

$ ./build/qemu-system-riscv64 -S -M virt -display none -qmp  tcp:localhost:=
1234,server,wait=3Doff

Then use QMP to access the API:

$ ./scripts/qmp/qmp-shell localhost:1234
Welcome to the QMP low-level shell!
Connected to QEMU 8.1.50

(QEMU)  query-cpu-model-expansion type=3Dfull model=3D{"name":"rv64"}
{"return": {"model": {"name": "rv64", "props": {"zicond": false, "x-zvfh": =
false, "mmu": true, "x-zvfbfwma": false, "x-zvfbfmin": false, "xtheadbs": f=
alse, "xtheadbb": false, "xtheadba": false, "xtheadmemidx": false, "smstate=
en": false, "zfinx": false, "Zve64f": false, "Zve32f": false, "x-zvfhmin": =
false, "xventanacondops": false, "xtheadcondmov": false, "svpbmt": false, "=
zbs": true, "zbc": true, "zbb": true, "zba": true, "zicboz": true, "xtheadm=
ac": false, "Zfh": false, "Zfa": true, "zbkx": false, "zbkc": false, "zbkb"=
: false, "Zve64d": false, "x-zfbfmin": false, "zk": false, "x-epmp": false,=
 "xtheadmempair": false, "zkt": false, "zks": false, "zkr": false, "zkn": f=
alse, "Zfhmin": false, "zksh": false, "zknh": false, "zkne": false, "zknd":=
 false, "zhinx": false, "Zicsr": true, "sscofpmf": false, "Zihintntl": true=
, "sstc": true, "xtheadcmo": false, "x-zvbb": false, "zksed": false, "x-zvk=
ned": false, "xtheadsync": false, "x-zvkg": false, "zhinxmin": false, "svad=
u": true, "xtheadfmv": false, "x-zvksed": false, "svnapot": false, "pmp": t=
rue, "x-zvknhb": false, "x-zvknha": false, "xtheadfmemidx": false, "x-zvksh=
": false, "zdinx": false, "zicbom": true, "Zihintpause": true, "svinval": f=
alse, "zcf": false, "zce": false, "zcd": false, "zcb": false, "zca": false,=
 "x-ssaia": false, "x-smaia": false, "zmmul": false, "x-zvbc": false, "Zife=
ncei": true, "zcmt": false, "zcmp": false, "Zawrs": true}}}}

Changes from v1:
- patches 1 and 2 from v1 were removed and sent in separate
- v1 link: https://lore.kernel.org/qemu-riscv/20230920213743.716265-1-dbarb=
oza@ventanamicro.com/


Daniel Henrique Barboza (6):
  target/riscv/kvm/kvm-cpu.c: add missing property getters()
  qapi,risc-v: add query-cpu-model-expansion
  target/riscv/tcg: add tcg_cpu_finalize_features()
  target/riscv: handle custom props in qmp_query_cpu_model_expansion
  target/riscv: add riscv_cpu_accelerator_compatible()
  target/riscv/riscv-qmp-cmds.c: check CPU accel in
    query-cpu-model-expansion

 qapi/machine-target.json      |   6 +-
 target/riscv/cpu.c            |  27 +++++-
 target/riscv/cpu.h            |   2 +
 target/riscv/kvm/kvm-cpu.c    |  40 ++++++++-
 target/riscv/riscv-qmp-cmds.c | 160 ++++++++++++++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c    |  68 +++++++++------
 target/riscv/tcg/tcg-cpu.h    |   2 +
 7 files changed, 269 insertions(+), 36 deletions(-)

--=20
2.41.0


