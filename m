Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0254D7475A1
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:52:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGiJa-0007XJ-P9; Tue, 04 Jul 2023 11:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+cf2aa98949e522d56bcb+7254+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qGiJW-0007Wn-PC
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:51:38 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+cf2aa98949e522d56bcb+7254+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qGiJU-000805-Jz
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=jI7zKGQ3gRXN+oXWN6iBtxjK5EFSh9wbso5Nq2z8N5w=; b=sEiwtHmuU6jyKcXI5SmdQPEvqD
 1F/+oUyc2B5VfWkrxi03HJaddmR2Bg2Jej1J+qJsLJmtuGZ00C4aC9EMZQrT0vj01+RVNJ5FEAbIP
 v8tPt/ANrC4I5yDWmL3rvdXP0/esRvtCeR6PAu/Ajg3J84cfzxpfWji/M0+55I5B6rc1LduhxCCtj
 rDCmwYbikTRELco6dr4fKqgdjMiFWjAWtFQ/duUwz2BiJJXkPxS4+farxest5wbTaVQ1oKM6OjQZn
 igoQM/fKgv8dd/m/o3BhwsqHLsckev7StkqgAoe6bxb8b6URTFm2UUJ/apdE3bTlbpkWDPmZ5r+nQ
 u9Ug0aKg==;
Received: from [2001:8b0:10b:5:36c:5942:7c03:2db0]
 (helo=u3832b3a9db3152.ant.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1qGiJS-009GuK-Hm; Tue, 04 Jul 2023 15:51:34 +0000
Message-ID: <4d45f38c586d17f878034fdec14e53be1cb83059.camel@infradead.org>
Subject: [PATCH v2] i386/xen: consistent locking around Xen singleshot timers
From: David Woodhouse <dwmw2@infradead.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Paul Durrant
 <paul@xen.org>
Date: Tue, 04 Jul 2023 16:51:34 +0100
In-Reply-To: <318049e6f803afa150c38190e5ce3540e1b82c8d.camel@infradead.org>
References: <20230302123029.153265-1-pbonzini@redhat.com>
 <20230302123029.153265-33-pbonzini@redhat.com>
 <CAFEAcA-s+sNDn4z_kXd70koFGSLXqjMUXB5Gn9VzTnaSbr2B_Q@mail.gmail.com>
 <d61333c6394697d88dd08d48cc7fa730ff8e1987.camel@infradead.org>
 <CAFEAcA_CR0PraF1DuDxw6q9U=Atut_=v0L1gHr6VfgxHCbmJXw@mail.gmail.com>
 <318049e6f803afa150c38190e5ce3540e1b82c8d.camel@infradead.org>
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-paggs13wns28VAeCzKU3"
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+cf2aa98949e522d56bcb+7254+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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


--=-paggs13wns28VAeCzKU3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

Coverity points out (CID 1507534, 1507968) that we sometimes access
env->xen_singleshot_timer_ns under the protection of
env->xen_timers_lock and sometimes not.

This isn't always an issue. There are two modes for the timers; if the
kernel supports the EVTCHN_SEND capability then it handles all the timer
hypercalls and delivery internally, and all we use the field for is to
get/set the timer as part of the vCPU state via an ioctl(). If the
kernel doesn't have that support, then we do all the emulation within
qemu, and *those* are the code paths where we actually care about the
locking.

But it doesn't hurt to be a little bit more consistent and avoid having
to explain *why* it's OK.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 target/i386/kvm/xen-emu.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index d7c7eb8d9c..9946ff0905 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -43,6 +43,7 @@
=20
 static void xen_vcpu_singleshot_timer_event(void *opaque);
 static void xen_vcpu_periodic_timer_event(void *opaque);
+static int vcpuop_stop_singleshot_timer(CPUState *cs);
=20
 #ifdef TARGET_X86_64
 #define hypercall_compat32(longmode) (!(longmode))
@@ -466,6 +467,7 @@ void kvm_xen_inject_vcpu_callback_vector(uint32_t vcpu_=
id, int type)
     }
 }
=20
+/* Must always be called with xen_timers_lock held */
 static int kvm_xen_set_vcpu_timer(CPUState *cs)
 {
     X86CPU *cpu =3D X86_CPU(cs);
@@ -483,6 +485,7 @@ static int kvm_xen_set_vcpu_timer(CPUState *cs)
=20
 static void do_set_vcpu_timer_virq(CPUState *cs, run_on_cpu_data data)
 {
+    QEMU_LOCK_GUARD(&X86_CPU(cs)->env.xen_timers_lock);
     kvm_xen_set_vcpu_timer(cs);
 }
=20
@@ -545,7 +548,6 @@ static void do_vcpu_soft_reset(CPUState *cs, run_on_cpu=
_data data)
     env->xen_vcpu_time_info_gpa =3D INVALID_GPA;
     env->xen_vcpu_runstate_gpa =3D INVALID_GPA;
     env->xen_vcpu_callback_vector =3D 0;
-    env->xen_singleshot_timer_ns =3D 0;
     memset(env->xen_virq, 0, sizeof(env->xen_virq));
=20
     set_vcpu_info(cs, INVALID_GPA);
@@ -555,8 +557,13 @@ static void do_vcpu_soft_reset(CPUState *cs, run_on_cp=
u_data data)
                           INVALID_GPA);
     if (kvm_xen_has_cap(EVTCHN_SEND)) {
         kvm_xen_set_vcpu_callback_vector(cs);
+
+        QEMU_LOCK_GUARD(&X86_CPU(cs)->env.xen_timers_lock);
+        env->xen_singleshot_timer_ns =3D 0;
         kvm_xen_set_vcpu_timer(cs);
-    }
+    } else {
+        vcpuop_stop_singleshot_timer(cs);
+    };
=20
 }
=20
@@ -1059,6 +1066,10 @@ static int vcpuop_stop_periodic_timer(CPUState *targ=
et)
     return 0;
 }
=20
+/*
+ * Userspace handling of timer, for older kernels.
+ * Must always be called with xen_timers_lock held.
+ */
 static int do_set_singleshot_timer(CPUState *cs, uint64_t timeout_abs,
                                    bool future, bool linux_wa)
 {
@@ -1086,12 +1097,8 @@ static int do_set_singleshot_timer(CPUState *cs, uin=
t64_t timeout_abs,
         timeout_abs =3D now + delta;
     }
=20
-    qemu_mutex_lock(&env->xen_timers_lock);
-
     timer_mod_ns(env->xen_singleshot_timer, qemu_now + delta);
     env->xen_singleshot_timer_ns =3D now + delta;
-
-    qemu_mutex_unlock(&env->xen_timers_lock);
     return 0;
 }
=20
@@ -1115,6 +1122,7 @@ static int vcpuop_set_singleshot_timer(CPUState *cs, =
uint64_t arg)
         return -EFAULT;
     }
=20
+    QEMU_LOCK_GUARD(&X86_CPU(cs)->env.xen_timers_lock);
     return do_set_singleshot_timer(cs, sst.timeout_abs_ns,
                                    !!(sst.flags & VCPU_SSHOTTMR_future),
                                    false);
@@ -1141,6 +1149,7 @@ static bool kvm_xen_hcall_set_timer_op(struct kvm_xen=
_exit *exit, X86CPU *cpu,
     if (unlikely(timeout =3D=3D 0)) {
         err =3D vcpuop_stop_singleshot_timer(CPU(cpu));
     } else {
+        QEMU_LOCK_GUARD(&X86_CPU(cpu)->env.xen_timers_lock);
         err =3D do_set_singleshot_timer(CPU(cpu), timeout, false, true);
     }
     exit->u.hcall.result =3D err;
@@ -1826,6 +1835,7 @@ int kvm_put_xen_state(CPUState *cs)
          * If the kernel has EVTCHN_SEND support then it handles timers to=
o,
          * so the timer will be restored by kvm_xen_set_vcpu_timer() below=
.
          */
+        QEMU_LOCK_GUARD(&env->xen_timers_lock);
         if (env->xen_singleshot_timer_ns) {
             ret =3D do_set_singleshot_timer(cs, env->xen_singleshot_timer_=
ns,
                                     false, false);
@@ -1844,10 +1854,7 @@ int kvm_put_xen_state(CPUState *cs)
     }
=20
     if (env->xen_virq[VIRQ_TIMER]) {
-        ret =3D kvm_xen_set_vcpu_timer(cs);
-        if (ret < 0) {
-            return ret;
-        }
+        do_set_vcpu_timer_virq(cs, RUN_ON_CPU_HOST_INT(env->xen_virq[VIRQ_=
TIMER]));
     }
     return 0;
 }
@@ -1896,6 +1903,15 @@ int kvm_get_xen_state(CPUState *cs)
         if (ret < 0) {
             return ret;
         }
+
+        /*
+         * This locking is fairly pointless, and is here to appease Coveri=
ty.
+         * There is an unavoidable race condition if a different vCPU sets=
 a
+         * timer for this vCPU after the value has been read out. But that=
's
+         * OK in practice because *all* the vCPUs need to be stopped befor=
e
+         * we set about migrating their state.
+         */
+        QEMU_LOCK_GUARD(&X86_CPU(cs)->env.xen_timers_lock);
         env->xen_singleshot_timer_ns =3D va.u.timer.expires_ns;
     }
=20
--=20
2.34.1



--=-paggs13wns28VAeCzKU3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMwNzA0MTU1MTM0WjAvBgkqhkiG9w0BCQQxIgQgzC81+TsE
SWQVYvY0L+AgCVKl93Ny64B3ZdcyrsbJTUcwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgCPMHOhxQ5JbzAnnapwzRpeVzSoh7ubbsA7
9zXfsusCPeYCNQV2ZObAy6vIrzaWRXwmenEmgr8WBqOrCskrVusxNdQ/IyZlUUFbnBInrfBOlYMc
VoseyBDAZguaMuEv4MrPmPt/hFS4crJ/PENyQKr5VYg6UVgKmqIbEQSVGxpQEU7CGkR43MLdn3nh
hK0ee4wzETHWYt5jO8mowcISx0D2KVioXgkwcw25wWGtmXBUCnZzHRp9HBVI0f5xH9aBK1apJm4w
/RjbsyYgJ0Gp4kFP0OdzxOe5EZsKIE/TCWX8at99py/Nix16JdA1gzhrndbN6rrqxRzXs1xuayHh
aj6uArgpN9tym7w+baI8N46lHT2MwgNgOgrM6PYaul9DQm/lJhoQYps8FuR9ViH40zjLcLAyVwxs
awxPGCFMPOyc/A9Eb8F2NafBWBylsrubeyEItd4Uc+pVe+5KbyZibK8LJ6lb2kFIgkFZQFQar39g
9ot3wj0SNpbc2zUduDP/nMasZ+2FPB85mw5+OJbHEMWcaALUHWZJvs0F8KCFdwRsIf++RpqR8nzf
ZlGLXxNpw+dsQhDEzWvQvkVBfbD7tQUrVossOO+e0qeaU9neBWSa8XeQdEREMmQ+MFST2GvBa0ef
rRvqI8w/TsB1oypXx7mVhGxHKvUH8+bwtcBow8m/VgAAAAAAAA==


--=-paggs13wns28VAeCzKU3--

