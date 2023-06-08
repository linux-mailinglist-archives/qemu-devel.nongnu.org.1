Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 075D4727947
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 09:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7AUW-0004SV-6A; Thu, 08 Jun 2023 03:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1q7AUT-0004S0-BW
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 03:55:29 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1q7AUQ-0004Pj-A4
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 03:55:29 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f6195d2b3fso414666e87.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 00:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686210924; x=1688802924; 
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=d2ehaVyvCobDzWI+dKc/BeAw3EsnQUI4lbnvpLGXrHw=;
 b=f5lprg6qDFOe5eybzpEsupyPVR8x0qcnYrUT1AaAGueMxVL3mVWIALziXsCPJo0isu
 DwNFLD3UEejCkE3l1N1/YL1HpuUDXYmpbNlnnZWnUpusFWz5ZUr8BU10+ujdmzGJcjXD
 a+obOULqHdpEoVB8ZGRvDcTSRpUVtqCwY3LrFrZ5jGZeMIptHdAjcZnpY+5choj8ca/8
 kK8/GLrah7Vm2Pn9Y1KTSosiKiU4n7LXRk0Tqzovv/NgYGCYIN7eQmlWIcxT2VpadLtY
 eBdoNYK0epC40wQgVrK97uwGH5BOBU1l/3BwANolE9ipd79H5Sd0XUl53yKGzeizKifY
 /A/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686210924; x=1688802924;
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
 :subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d2ehaVyvCobDzWI+dKc/BeAw3EsnQUI4lbnvpLGXrHw=;
 b=HjgpKi5r2sXo7ILO72jTsqi/SpjjFb+YwOPwDX5u9NuVLhRmb6XhcSFb52dOqIyn1W
 6fSrn6tAGsI/am6/zxFHw3QzBicjxHHBMr47BkNOQPTjJ2hDQ0f5Ihs2BbP8jbf8rodi
 /lLJS4BQlLmgNiNKiZE5v2oFCMLMF0QKZVNPoh0CxhKMwa4OG9U/i+y3SrJxuJvBeZhU
 D+IwhYmtXlyAyH1xDxgGpEu/Hnj9fJomgjgqqA6ZcAy2UOc70DlqHGxBrsixkGPt6ZHW
 9LQu5hhhV+wEJUDKUB3YeaxT2+DX5AvvenRPG52AnEFj9R7NFdsYgfIsZTiN8vrkTIRX
 9KCA==
X-Gm-Message-State: AC+VfDz8Z/CshDJ35tSDvCkUxR24dtGiXEgpnrrwrlRyBB/TzKJv8gaU
 tW+Ww9Pg5HmXbT8zmpEh/4tso4f6AwARCBv33N5U8A==
X-Google-Smtp-Source: ACHHUZ4yhoUi0bk49aoVI4hVwTGM7QVID9S/VBkv+3JOk6+Uk79Z++4iylApiSUBp7nOaxx94jUXgA==
X-Received: by 2002:ac2:5dd6:0:b0:4f3:c774:1923 with SMTP id
 x22-20020ac25dd6000000b004f3c7741923mr3321469lfq.11.1686210923760; 
 Thu, 08 Jun 2023 00:55:23 -0700 (PDT)
Received: from [192.168.50.45] (h-155-4-92-80.A980.priv.bahnhof.se.
 [155.4.92.80]) by smtp.gmail.com with ESMTPSA id
 j15-20020ac2454f000000b004efedad4604sm99133lfm.18.2023.06.08.00.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 00:55:23 -0700 (PDT)
Message-ID: <7f8d733df6e9b6151e9efb843d55441348805e70.camel@rivosinc.com>
Subject: [RFC v3] linux-user/riscv: Add syscall riscv_hwprobe
From: Robbin Ehn <rehn@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, qemu-riscv@nongnu.org, richard.henderson@linaro.org, 
 ajones@ventanamicro.com
Date: Thu, 08 Jun 2023 09:55:22 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=rehn@rivosinc.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This patch adds the new syscall for the
"RISC-V Hardware Probing Interface"
(https://docs.kernel.org/riscv/hwprobe.html).

Signed-off-by: Robbin Ehn <rehn@rivosinc.com>
---
v1->v2: Moved to syscall.c
v2->v3: Separate function, get/put user
---
 linux-user/riscv/syscall32_nr.h |   1 +
 linux-user/riscv/syscall64_nr.h |   1 +
 linux-user/syscall.c            | 146 ++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)

diff --git a/linux-user/riscv/syscall32_nr.h b/linux-user/riscv/syscall32_n=
r.h
index 1327d7dffa..412e58e5b2 100644
--- a/linux-user/riscv/syscall32_nr.h
+++ b/linux-user/riscv/syscall32_nr.h
@@ -228,6 +228,7 @@
 #define TARGET_NR_accept4 242
 #define TARGET_NR_arch_specific_syscall 244
 #define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15=
)
+#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
 #define TARGET_NR_prlimit64 261
 #define TARGET_NR_fanotify_init 262
 #define TARGET_NR_fanotify_mark 263
diff --git a/linux-user/riscv/syscall64_nr.h b/linux-user/riscv/syscall64_n=
r.h
index 6659751933..29e1eb2075 100644
--- a/linux-user/riscv/syscall64_nr.h
+++ b/linux-user/riscv/syscall64_nr.h
@@ -251,6 +251,7 @@
 #define TARGET_NR_recvmmsg 243
 #define TARGET_NR_arch_specific_syscall 244
 #define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15=
)
+#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
 #define TARGET_NR_wait4 260
 #define TARGET_NR_prlimit64 261
 #define TARGET_NR_fanotify_init 262
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 83685f0aa5..e8859cd3be 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8874,6 +8874,147 @@ static int do_getdents64(abi_long dirfd, abi_long a=
rg2, abi_long count)
 }
 #endif /* TARGET_NR_getdents64 */
=20
+#if defined(TARGET_NR_riscv_hwprobe)
+
+#define RISCV_HWPROBE_KEY_MVENDORID     0
+#define RISCV_HWPROBE_KEY_MARCHID       1
+#define RISCV_HWPROBE_KEY_MIMPID        2
+
+#define RISCV_HWPROBE_KEY_BASE_BEHAVIOR 3
+#define     RISCV_HWPROBE_BASE_BEHAVIOR_IMA (1 << 0)
+
+#define RISCV_HWPROBE_KEY_IMA_EXT_0     4
+#define     RISCV_HWPROBE_IMA_FD       (1 << 0)
+#define     RISCV_HWPROBE_IMA_C        (1 << 1)
+
+#define RISCV_HWPROBE_KEY_CPUPERF_0     5
+#define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
+#define     RISCV_HWPROBE_MISALIGNED_EMULATED    (1 << 0)
+#define     RISCV_HWPROBE_MISALIGNED_SLOW        (2 << 0)
+#define     RISCV_HWPROBE_MISALIGNED_FAST        (3 << 0)
+#define     RISCV_HWPROBE_MISALIGNED_UNSUPPORTED (4 << 0)
+#define     RISCV_HWPROBE_MISALIGNED_MASK        (7 << 0)
+
+struct riscv_hwprobe {
+    abi_llong  key;
+    abi_ullong value;
+};
+
+static void risc_hwprobe_fill_pairs(CPURISCVState *env,
+                                    struct riscv_hwprobe *pair,
+                                    size_t pair_count)
+{
+    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
+
+    for (; pair_count > 0; pair_count--, pair++) {
+        abi_llong key;
+        abi_ullong value;
+        __put_user(0, &pair->value);
+        __get_user(key, &pair->key);
+        switch (key) {
+        case RISCV_HWPROBE_KEY_MVENDORID:
+            __put_user(cfg->mvendorid, &pair->value);
+            break;
+        case RISCV_HWPROBE_KEY_MARCHID:
+            __put_user(cfg->marchid, &pair->value);
+            break;
+        case RISCV_HWPROBE_KEY_MIMPID:
+            __put_user(cfg->mimpid, &pair->value);
+            break;
+        case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
+            value =3D riscv_has_ext(env, RVI) &&
+                    riscv_has_ext(env, RVM) &&
+                    riscv_has_ext(env, RVA) ?
+                    RISCV_HWPROBE_BASE_BEHAVIOR_IMA : 0;
+            __put_user(value, &pair->value);
+            break;
+        case RISCV_HWPROBE_KEY_IMA_EXT_0:
+            value =3D riscv_has_ext(env, RVF) &&
+                    riscv_has_ext(env, RVD) ?
+                    RISCV_HWPROBE_IMA_FD : 0;
+            value |=3D riscv_has_ext(env, RVC) ?
+                     RISCV_HWPROBE_IMA_C : pair->value;
+            __put_user(value, &pair->value);
+            break;
+        case RISCV_HWPROBE_KEY_CPUPERF_0:
+            __put_user(RISCV_HWPROBE_MISALIGNED_FAST, &pair->value);
+            break;
+        default:
+            __put_user(-1, &pair->key);
+            break;
+        }
+    }
+}
+
+static int cpu_set_valid(abi_long arg3, abi_long arg4)
+{
+    int ret, i, tmp;
+    size_t host_mask_size, target_mask_size;
+    unsigned long *host_mask;
+
+    /*
+     * cpu_set_t represent CPU masks as bit masks of type unsigned long *.
+     * arg3 contains the cpu count.
+     */
+    tmp =3D (8 * sizeof(abi_ulong));
+    target_mask_size =3D ((arg3 + tmp - 1) / tmp) * sizeof(abi_ulong);
+    host_mask_size =3D (target_mask_size + (sizeof(*host_mask) - 1)) &
+                     ~(sizeof(*host_mask) - 1);
+
+    host_mask =3D alloca(host_mask_size);
+
+    ret =3D target_to_host_cpu_mask(host_mask, host_mask_size,
+                                  arg4, target_mask_size);
+    if (ret !=3D 0) {
+        return ret;
+    }
+
+    for (i =3D 0 ; i < host_mask_size / sizeof(*host_mask); i++) {
+        if (host_mask[i] !=3D 0) {
+            return 0;
+        }
+    }
+    return -TARGET_EINVAL;
+}
+
+static abi_long do_riscv_hwprobe(CPUArchState *cpu_env, abi_long arg1,
+                                 abi_long arg2, abi_long arg3,
+                                 abi_long arg4, abi_long arg5)
+{
+    int ret;
+    struct riscv_hwprobe *host_pairs;
+
+    /* flags must be 0 */
+    if (arg5 !=3D 0) {
+        return -TARGET_EINVAL;
+    }
+
+    /* check cpu_set */
+    if (arg3 !=3D 0) {
+        ret =3D cpu_set_valid(arg3, arg4);
+        if (ret !=3D 0) {
+            return ret;
+        }
+    } else if (arg4 !=3D 0) {
+        return -TARGET_EINVAL;
+    }
+
+    /* no pairs */
+    if (arg2 =3D=3D 0) {
+        return 0;
+    }
+
+    host_pairs =3D lock_user(VERIFY_WRITE, arg1,
+                           sizeof(*host_pairs) * (size_t)arg2, 0);
+    if (host_pairs =3D=3D NULL) {
+        return -TARGET_EFAULT;
+    }
+    risc_hwprobe_fill_pairs(cpu_env, host_pairs, arg2);
+    unlock_user(host_pairs, arg1, sizeof(*host_pairs) * (size_t)arg2);
+    return 0;
+}
+#endif /* TARGET_NR_riscv_hwprobe */
+
 #if defined(TARGET_NR_pivot_root) && defined(__NR_pivot_root)
 _syscall2(int, pivot_root, const char *, new_root, const char *, put_old)
 #endif
@@ -13571,6 +13712,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env,=
 int num, abi_long arg1,
         return ret;
 #endif
=20
+#if defined(TARGET_NR_riscv_hwprobe)
+    case TARGET_NR_riscv_hwprobe:
+        return do_riscv_hwprobe(cpu_env, arg1, arg2, arg3, arg4, arg5);
+#endif
+
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
         return -TARGET_ENOSYS;
--=20
2.39.2



