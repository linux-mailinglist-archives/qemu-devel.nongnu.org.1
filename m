Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB9B87344A
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Mar 2024 11:32:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhoYw-0004y6-Hd; Wed, 06 Mar 2024 05:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rhoYo-0004oX-CK
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:31:42 -0500
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rhoYk-0007bf-Fx
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:31:41 -0500
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1709721086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=On8HB8y1tTMJab2j+fd5XKn/1OC8xVc0eTzEZSkIC8Y=;
 b=HH0EI01LDfD0jXkDmJ9N2YysYieZcHTAmB0XskLqbmj/oGSPZMLCETI5jF607MEf92xk22
 gHJSenMCuqv0Z4SVQp89M9X2rRG0FrwE3d3QInruVWq04MO9jW/lcxaZVwAP2/F4SDyp/j
 W/rxpQKkEZmF3JzxBWb7ZIVrYIsLdGSLbqh3Pg7UK8evML5dOCw+v5f34Opwr5I1xsmpgh
 AbC6iMXdIprNg1GLGf4ePT2dlhKM+W2fbNeCy45ilCu2UFFaU7si0iUkbtckHNpS2wwPe3
 8t5Kq+UUGrfdtVaGzwvP491+5KZo0bsL8TPkXvEdiy49p8+tRKeZxI3jYUlk6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1709721086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=On8HB8y1tTMJab2j+fd5XKn/1OC8xVc0eTzEZSkIC8Y=;
 b=1pwhfpdEfZHXamuYjt0ABjVOS3ZVIZfkIKK1vtP1x2rEyWciNoFNqhs9wO/n2Xm+syfiw4
 YI1GstoR7V8ZCGBQ==
Date: Wed, 06 Mar 2024 11:31:22 +0100
Subject: [PATCH 1/4] docs/interop/firmware.json: Align examples
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240306-qapi-firmware-json-v1-1-619f7122a249@linutronix.de>
References: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
In-Reply-To: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709721085; l=11093;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=GMe7kp9V6sMusbYpESY64Sjm/vPnPDkcVXvAuqt/pIQ=;
 b=AQix6REujC8fmyYK4WHAfyFhm59vOyuNMXhTzYvnKu0CxZKlD6Rv0C9U1bzMEbqH8bK9fSZsd
 X1ZO2GYt1BtDUae9IrdxzqM9WDkAe9ylp9FaQ98f50JxSHgokvAFJGD
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=2a0a:51c0:0:12e:550::1;
 envelope-from=t-8ch@linutronix.de; helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The QAPI generator now validates the alignment and rejects this file.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/interop/firmware.json | 384 ++++++++++++++++++++++-----------------------
 1 file changed, 192 insertions(+), 192 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index cc8f86918681..a024f1b9bf3f 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -435,203 +435,203 @@
 #
 # Examples:
 #
-# {
-#     "description": "SeaBIOS",
-#     "interface-types": [
-#         "bios"
-#     ],
-#     "mapping": {
-#         "device": "memory",
-#         "filename": "/usr/share/seabios/bios-256k.bin"
-#     },
-#     "targets": [
-#         {
-#             "architecture": "i386",
-#             "machines": [
-#                 "pc-i440fx-*",
-#                 "pc-q35-*"
-#             ]
+#     {
+#         "description": "SeaBIOS",
+#         "interface-types": [
+#             "bios"
+#         ],
+#         "mapping": {
+#             "device": "memory",
+#             "filename": "/usr/share/seabios/bios-256k.bin"
 #         },
-#         {
-#             "architecture": "x86_64",
-#             "machines": [
-#                 "pc-i440fx-*",
-#                 "pc-q35-*"
-#             ]
-#         }
-#     ],
-#     "features": [
-#         "acpi-s3",
-#         "acpi-s4"
-#     ],
-#     "tags": [
-#         "CONFIG_BOOTSPLASH=n",
-#         "CONFIG_ROM_SIZE=256",
-#         "CONFIG_USE_SMM=n"
-#     ]
-# }
-#
-# {
-#     "description": "OVMF with SB+SMM, empty varstore",
-#     "interface-types": [
-#         "uefi"
-#     ],
-#     "mapping": {
-#         "device": "flash",
-#         "executable": {
-#             "filename": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
-#             "format": "raw"
+#         "targets": [
+#             {
+#                 "architecture": "i386",
+#                 "machines": [
+#                     "pc-i440fx-*",
+#                     "pc-q35-*"
+#                 ]
+#             },
+#             {
+#                 "architecture": "x86_64",
+#                 "machines": [
+#                     "pc-i440fx-*",
+#                     "pc-q35-*"
+#                 ]
+#             }
+#         ],
+#         "features": [
+#             "acpi-s3",
+#             "acpi-s4"
+#         ],
+#         "tags": [
+#             "CONFIG_BOOTSPLASH=n",
+#             "CONFIG_ROM_SIZE=256",
+#             "CONFIG_USE_SMM=n"
+#         ]
+#     }
+#
+#     {
+#         "description": "OVMF with SB+SMM, empty varstore",
+#         "interface-types": [
+#             "uefi"
+#         ],
+#         "mapping": {
+#             "device": "flash",
+#             "executable": {
+#                 "filename": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
+#                 "format": "raw"
+#             },
+#             "nvram-template": {
+#                 "filename": "/usr/share/OVMF/OVMF_VARS.fd",
+#                 "format": "raw"
+#             }
 #         },
-#         "nvram-template": {
-#             "filename": "/usr/share/OVMF/OVMF_VARS.fd",
-#             "format": "raw"
-#         }
-#     },
-#     "targets": [
-#         {
-#             "architecture": "x86_64",
-#             "machines": [
-#                 "pc-q35-*"
-#             ]
-#         }
-#     ],
-#     "features": [
-#         "acpi-s3",
-#         "amd-sev",
-#         "requires-smm",
-#         "secure-boot",
-#         "verbose-dynamic"
-#     ],
-#     "tags": [
-#         "-a IA32",
-#         "-a X64",
-#         "-p OvmfPkg/OvmfPkgIa32X64.dsc",
-#         "-t GCC48",
-#         "-b DEBUG",
-#         "-D SMM_REQUIRE",
-#         "-D SECURE_BOOT_ENABLE",
-#         "-D FD_SIZE_4MB"
-#     ]
-# }
-#
-# {
-#     "description": "OVMF with SB+SMM, SB enabled, MS certs enrolled",
-#     "interface-types": [
-#         "uefi"
-#     ],
-#     "mapping": {
-#         "device": "flash",
-#         "executable": {
-#             "filename": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
-#             "format": "raw"
+#         "targets": [
+#             {
+#                 "architecture": "x86_64",
+#                 "machines": [
+#                     "pc-q35-*"
+#                 ]
+#             }
+#         ],
+#         "features": [
+#             "acpi-s3",
+#             "amd-sev",
+#             "requires-smm",
+#             "secure-boot",
+#             "verbose-dynamic"
+#         ],
+#         "tags": [
+#             "-a IA32",
+#             "-a X64",
+#             "-p OvmfPkg/OvmfPkgIa32X64.dsc",
+#             "-t GCC48",
+#             "-b DEBUG",
+#             "-D SMM_REQUIRE",
+#             "-D SECURE_BOOT_ENABLE",
+#             "-D FD_SIZE_4MB"
+#         ]
+#     }
+#
+#     {
+#         "description": "OVMF with SB+SMM, SB enabled, MS certs enrolled",
+#         "interface-types": [
+#             "uefi"
+#         ],
+#         "mapping": {
+#             "device": "flash",
+#             "executable": {
+#                 "filename": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
+#                 "format": "raw"
+#             },
+#             "nvram-template": {
+#                 "filename": "/usr/share/OVMF/OVMF_VARS.secboot.fd",
+#                 "format": "raw"
+#             }
 #         },
-#         "nvram-template": {
-#             "filename": "/usr/share/OVMF/OVMF_VARS.secboot.fd",
-#             "format": "raw"
-#         }
-#     },
-#     "targets": [
-#         {
-#             "architecture": "x86_64",
-#             "machines": [
-#                 "pc-q35-*"
-#             ]
-#         }
-#     ],
-#     "features": [
-#         "acpi-s3",
-#         "amd-sev",
-#         "enrolled-keys",
-#         "requires-smm",
-#         "secure-boot",
-#         "verbose-dynamic"
-#     ],
-#     "tags": [
-#         "-a IA32",
-#         "-a X64",
-#         "-p OvmfPkg/OvmfPkgIa32X64.dsc",
-#         "-t GCC48",
-#         "-b DEBUG",
-#         "-D SMM_REQUIRE",
-#         "-D SECURE_BOOT_ENABLE",
-#         "-D FD_SIZE_4MB"
-#     ]
-# }
-#
-# {
-#     "description": "OVMF with SEV-ES support",
-#     "interface-types": [
-#         "uefi"
-#     ],
-#     "mapping": {
-#         "device": "flash",
-#         "executable": {
-#             "filename": "/usr/share/OVMF/OVMF_CODE.fd",
-#             "format": "raw"
+#         "targets": [
+#             {
+#                 "architecture": "x86_64",
+#                 "machines": [
+#                     "pc-q35-*"
+#                 ]
+#             }
+#         ],
+#         "features": [
+#             "acpi-s3",
+#             "amd-sev",
+#             "enrolled-keys",
+#             "requires-smm",
+#             "secure-boot",
+#             "verbose-dynamic"
+#         ],
+#         "tags": [
+#             "-a IA32",
+#             "-a X64",
+#             "-p OvmfPkg/OvmfPkgIa32X64.dsc",
+#             "-t GCC48",
+#             "-b DEBUG",
+#             "-D SMM_REQUIRE",
+#             "-D SECURE_BOOT_ENABLE",
+#             "-D FD_SIZE_4MB"
+#         ]
+#     }
+#
+#     {
+#         "description": "OVMF with SEV-ES support",
+#         "interface-types": [
+#             "uefi"
+#         ],
+#         "mapping": {
+#             "device": "flash",
+#             "executable": {
+#                 "filename": "/usr/share/OVMF/OVMF_CODE.fd",
+#                 "format": "raw"
+#             },
+#             "nvram-template": {
+#                 "filename": "/usr/share/OVMF/OVMF_VARS.fd",
+#                 "format": "raw"
+#             }
 #         },
-#         "nvram-template": {
-#             "filename": "/usr/share/OVMF/OVMF_VARS.fd",
-#             "format": "raw"
-#         }
-#     },
-#     "targets": [
-#         {
-#             "architecture": "x86_64",
-#             "machines": [
-#                 "pc-q35-*"
-#             ]
-#         }
-#     ],
-#     "features": [
-#         "acpi-s3",
-#         "amd-sev",
-#         "amd-sev-es",
-#         "verbose-dynamic"
-#     ],
-#     "tags": [
-#         "-a X64",
-#         "-p OvmfPkg/OvmfPkgX64.dsc",
-#         "-t GCC48",
-#         "-b DEBUG",
-#         "-D FD_SIZE_4MB"
-#     ]
-# }
-#
-# {
-#     "description": "UEFI firmware for ARM64 virtual machines",
-#     "interface-types": [
-#         "uefi"
-#     ],
-#     "mapping": {
-#         "device": "flash",
-#         "executable": {
-#             "filename": "/usr/share/AAVMF/AAVMF_CODE.fd",
-#             "format": "raw"
+#         "targets": [
+#             {
+#                 "architecture": "x86_64",
+#                 "machines": [
+#                     "pc-q35-*"
+#                 ]
+#             }
+#         ],
+#         "features": [
+#             "acpi-s3",
+#             "amd-sev",
+#             "amd-sev-es",
+#             "verbose-dynamic"
+#         ],
+#         "tags": [
+#             "-a X64",
+#             "-p OvmfPkg/OvmfPkgX64.dsc",
+#             "-t GCC48",
+#             "-b DEBUG",
+#             "-D FD_SIZE_4MB"
+#         ]
+#     }
+#
+#     {
+#         "description": "UEFI firmware for ARM64 virtual machines",
+#         "interface-types": [
+#             "uefi"
+#         ],
+#         "mapping": {
+#             "device": "flash",
+#             "executable": {
+#                 "filename": "/usr/share/AAVMF/AAVMF_CODE.fd",
+#                 "format": "raw"
+#             },
+#             "nvram-template": {
+#                 "filename": "/usr/share/AAVMF/AAVMF_VARS.fd",
+#                 "format": "raw"
+#             }
 #         },
-#         "nvram-template": {
-#             "filename": "/usr/share/AAVMF/AAVMF_VARS.fd",
-#             "format": "raw"
-#         }
-#     },
-#     "targets": [
-#         {
-#             "architecture": "aarch64",
-#             "machines": [
-#                 "virt-*"
-#             ]
-#         }
-#     ],
-#     "features": [
-#
-#     ],
-#     "tags": [
-#         "-a AARCH64",
-#         "-p ArmVirtPkg/ArmVirtQemu.dsc",
-#         "-t GCC48",
-#         "-b DEBUG",
-#         "-D DEBUG_PRINT_ERROR_LEVEL=0x80000000"
-#     ]
-# }
+#         "targets": [
+#             {
+#                 "architecture": "aarch64",
+#                 "machines": [
+#                     "virt-*"
+#                 ]
+#             }
+#         ],
+#         "features": [
+#
+#         ],
+#         "tags": [
+#             "-a AARCH64",
+#             "-p ArmVirtPkg/ArmVirtQemu.dsc",
+#             "-t GCC48",
+#             "-b DEBUG",
+#             "-D DEBUG_PRINT_ERROR_LEVEL=0x80000000"
+#         ]
+#     }
 ##
 { 'struct' : 'Firmware',
   'data'   : { 'description'     : 'str',

-- 
2.44.0


