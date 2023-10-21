Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CF67D1D4F
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 15:50:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quCLh-0003L9-SZ; Sat, 21 Oct 2023 09:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <udo@hypervisor.org>)
 id 1quBAZ-0004NC-3L
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 08:33:31 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <udo@hypervisor.org>)
 id 1quBAS-00089w-4P
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 08:33:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1697891592; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=hk4tiO/Jo6czbrwlptaYm4nnvDzoZw4ab8sJwevotI6tZhjFbu4fzBT02Gznnt52ZK
 +WYt7iKSFazLnqbyIo9A6RPzF8AzBvd8pv1xNCioR/UnQ1g2YhPNdXAnhHFGlM91jxzY
 4zXVOGoxYhEAAPbWtHd5q/CkAELt+7ZMfh9eQf723fVLn6QalBRZLiKScHcm3FJvpBuC
 fexkgwtASaEjdbhjol9YrUSC+LPbg0hdTx3JycaYZEMzTLic2I1sXeSx73GS8fF93AW+
 205QkqillP2a2eBixm0ZLnlgc1n9/Fcz+E4KKVQ7I6S7FyH4ToXjj/vpr+IZGWK5YHXd
 fJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1697891592;
 s=strato-dkim-0002; d=strato.com;
 h=Message-ID:Subject:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
 bh=HzwRB0F4pvHnIBGXM6EU4q85FwTXt+4I6sYu8DtVTS4=;
 b=hmQYqOsqijRcE/v1Vt7gXe7Q4Xjv4+dQnqZQr77Z7f22cbxiESxGkGA+sFIpu+L92v
 hcTa8jHBxqG+HFpkvkciBkc0okZH0HK4T7OO2+McYoFFGp2ap7ppfZG1IlWh6q6mZYeu
 0HBQ9QdSO7EDl517BbH+0K9dTN43RNil37/f6IDUcwLs6p1uKsG6F0XxqLufMv1hqUb0
 dboEU7sNO3f9hydFgAxDQtACuZNAwb42KR47SKH8DOulusVLOr8wrv+KMN8hyONQKwEs
 97SAEtPK40Ly7Q0HBPrF3aH310Nm9r5PFL9UXEbhwV4vOSSyjHZzL2u54J76qLBzNxAc
 4kNQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1697891592;
 s=strato-dkim-0002; d=hypervisor.org;
 h=Message-ID:Subject:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
 bh=HzwRB0F4pvHnIBGXM6EU4q85FwTXt+4I6sYu8DtVTS4=;
 b=COAiW4lnsne+1upvrGSc3pFQ1AEBdvgn81Xz3XmPTyJn+yF1zYzKB+pHhFaeh34Tdz
 HbSwdkAbOJo1C2ujWLeFr+4Yx6+Q5CVXMJNKBw0t5d99KEeKt2+yQEuq+Csn41C0nsHy
 VcDDMBguoRMZapU5u63bE2lDg7dpxkm8HpuHN+2RlLDUoGuu9sDFaAZqHekFyjza3PtQ
 2crkbW5wxx8uVdMvbh0PM/gqBAyqZ3vyIt6VqyoP5bdNFzWDyKI045g1v7lft5L+h1UJ
 05bHqI8j6P2IbtQe+gEgfrVlpcyFASWAZgXte+GYmS2jRWEFLrfr+mNUSOCvsQ4gAGBE
 7Oiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1697891592;
 s=strato-dkim-0003; d=hypervisor.org;
 h=Message-ID:Subject:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
 bh=HzwRB0F4pvHnIBGXM6EU4q85FwTXt+4I6sYu8DtVTS4=;
 b=YbQBL9ZYC+ODJnArstBNOSHGKOVmF59zm3B9cyulVMazktF9VYwrvkYsq0KoNGUvKr
 b0KXP3DPZhDlusgmkjBA==
X-RZG-AUTH: ":OWgLVUixa/orYEjgByCmMbha6U0z53RZBchi0p8VsT1fAA5ylDfCvZjciEyyI00QO7yF"
Received: from darkstar.speedport.ip by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
 with ESMTPSA id N1a943z9LCXCrqu
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sat, 21 Oct 2023 14:33:12 +0200 (CEST)
Date: Sat, 21 Oct 2023 14:33:08 +0200
From: Udo Steinberg <udo@hypervisor.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: PATCH: #1938: [ARM/PL011] Wrong UART register spacing reported in
 DBG2/SPCR
Message-ID: <20231021143308.04f1a6fe@darkstar.speedport.ip>
X-Mailer: X-Mailer 5.0 Gold
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UsS/z8fNjlKsU3hFI=BFlhM";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=85.215.255.24; envelope-from=udo@hypervisor.org;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 URI_TRY_3LD=1.999 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 21 Oct 2023 09:48:46 -0400
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

--Sig_/UsS/z8fNjlKsU3hFI=BFlhM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


From: Udo Steinberg <udo@hypervisor.org>
Date: Sat, 21 Oct 2023 14:10:30 +0200
Subject: [PATCH] hw/arm/virt: Report correct register sizes in ACPI DBG2/SP=
CR
 tables.

Documentation for using the GAS in ACPI tables to report debug UART address=
es at
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-deb=
ug-port-table
states the following:

- The Register Bit Width field contains the register stride and must be a
  power of 2 that is at least as large as the access size.  On 32-bit
  platforms this value cannot exceed 32.  On 64-bit platforms this value
  cannot exceed 64.
- The Access Size field is used to determine whether byte, WORD, DWORD, or
  QWORD accesses are to be used.  QWORD accesses are only valid on 64-bit
  architectures.

Documentation for the ARM PL011 at
https://developer.arm.com/documentation/ddi0183/latest/
states that the registers are:

- spaced 4 bytes apart (see Table 3-2), so register stride must be 32.
- 16 bits in size (see individual registers), so access size must be 2.

The PL011 documentation does not mention whether 8-bit accesses or 32-bit
accesses to the registers are also allowed. Because a standard PL011 (not
the SBSA version) is connected via a 16-bit bus using PWDATA[15:0] and
PRDATA[15:0] (see Figure 2-1), using 16-bit access is the safest choice.

For SBSA-compatible UARTs the DBG2/SPCR table should report a different
subtype (0xd or 0xe) instead of 0x3.

Fixes #1938.

Signed-off-by: Udo Steinberg <udo@hypervisor.org>
---
 hw/arm/virt-acpi-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9ce136cd88..91ed7fc94a 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -482,7 +482,7 @@ build_spcr(GArray *table_data, BIOSLinker *linker, Virt=
MachineState *vms)
     build_append_int_noprefix(table_data, 3, 1); /* ARM PL011 UART */
     build_append_int_noprefix(table_data, 0, 3); /* Reserved */
     /* Base Address */
-    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 8, 0, 1,
+    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 32, 0, 2,
                      vms->memmap[VIRT_UART].base);
     /* Interrupt Type */
     build_append_int_noprefix(table_data,
@@ -673,7 +673,7 @@ build_dbg2(GArray *table_data, BIOSLinker *linker, Virt=
MachineState *vms)
     build_append_int_noprefix(table_data, 34, 2);
=20
     /* BaseAddressRegister[] */
-    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 8, 0, 1,
+    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 32, 0, 2,
                      vms->memmap[VIRT_UART].base);
=20
     /* AddressSize[] */
--=20
2.42.0


--Sig_/UsS/z8fNjlKsU3hFI=BFlhM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSkO5N26kOUIFJ7uuML5GVErCjMSwUCZTPFBAAKCRAL5GVErCjM
S8qXAP4vVEEPYVR61lROO3AFpCPUGJRI1hYkydEIyj+SOAoNpQD+KgoMoLg970mz
TNtVCpxNmECO1CGQ8cRYvhtnzBmX7AE=
=kULx
-----END PGP SIGNATURE-----

--Sig_/UsS/z8fNjlKsU3hFI=BFlhM--

