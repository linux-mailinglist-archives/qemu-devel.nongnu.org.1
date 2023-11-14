Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1C07EAD29
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 10:38:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2pqv-0000IK-E2; Tue, 14 Nov 2023 04:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r2pqr-0000Hv-Kr
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:36:58 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r2pqp-0007qM-Jm
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:36:57 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-58a0d0cdcc1so2546052eaf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 01:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699954614; x=1700559414; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKFjjCq2MLt5Ywb4JpaP15BYw44bNrhr2voccKW4RkU=;
 b=cc89ayxNt73KjztgNFVpzbMKILryfdMjoz9rbk2DhBvtDicOxNWwumpyIHM7MSOs61
 VmPn6WNwqog737FgWrh4zQTNUQVXogPjdtlGxQOn9kdiPKFkht/p9MUoSVb1YD3hx79j
 5ILEipvxzGuSxIIVnyN+vSSXEcr7T6fpkuNt2+9BHIiZ6rXCvfFRXDnxYaSpkC5PzWgw
 wR4CSZJQd7S4xF4+MooIhdEXhU/912CofbTRGEaG3hhMelcmyJ2ePWmvV4D2zJJZF2yq
 bXkNXdF0R60gX+366E253Q4F3rv+sAIUzHFImV/mNpHiI4XRnLnkxtHhIcCabXN+trRl
 hIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699954614; x=1700559414;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YKFjjCq2MLt5Ywb4JpaP15BYw44bNrhr2voccKW4RkU=;
 b=iOLXTPogQj2Tiz+Pzr7ggnlA0g6/J5w5Sj145zXlap8r/v7qaSf4tH5shm60CtiV5z
 jJNTCYBAXqf4WGg7I8mDbc6F6WID53LmNOcQED0bNUwN5GHs5aPrTtruvai7t/R9uTgU
 nF6gfqCJE12KmCDuSOcCcQFnwqaJowB+4Supjr7mfMAjgDaNDcp3/Ufey7zx5UZV4C82
 1Zt/rpnkpd9PWMDuvZ2NVvLg9gAVNt9kIqPrgXVpbELtZfKNX4zLkjhxdxz+n/NSu09g
 VQg8z+u1gct63iuaUb7y4Ldo/EE2M6roZ7szNzNS1A7XYCBiRrY+N4reP45ezokaHZl1
 Mf7A==
X-Gm-Message-State: AOJu0Yz3RLqeS3wWuakmIV5DCaRfDgFpLIKnTLjDlH8SAjdpO68ztuOr
 RSNcEvmrhQkJ7y/iojyJD/OPUGOtrNlmDUqanVo=
X-Google-Smtp-Source: AGHT+IFNVOW61F7KX04swc6lWU2YtR3HSopsd9F1cuSUBl5T2cKXLsOxYWZUlel+Di+j8VI2U0Ci4DkKuyJtqggfEnw=
X-Received: by 2002:a05:6358:591d:b0:16b:c401:e714 with SMTP id
 g29-20020a056358591d00b0016bc401e714mr1920987rwf.5.1699954613681; Tue, 14 Nov
 2023 01:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20231114020927.62315-1-j@getutm.app>
 <20231114020927.62315-13-j@getutm.app>
In-Reply-To: <20231114020927.62315-13-j@getutm.app>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Nov 2023 13:36:42 +0400
Message-ID: <CAJ+F1CKx_MfZapE_vcb_e-nk=CMC2e8FN0QrONb4mzda_KNKUQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/14] tests: acpi: implement TPM CRB tests for ARM virt
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Tue, Nov 14, 2023 at 6:12=E2=80=AFAM Joelle van Dyne <j@getutm.app> wrot=
e:
>
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

nit: you also added tests for x86, could be a different patch?

For arm, the test fails until next patch with:

# starting QEMU: exec ./qemu-system-aarch64 -qtest
unix:/tmp/qtest-991279.sock -qtest-log /dev/null -chardev
socket,path=3D/tmp/qtest-991279.qmp,id=3Dchar0 -mon
chardev=3Dchar0,mode=3Dcontrol -display none -audio none -machine virt
-accel tcg -nodefaults -nographic -drive
if=3Dpflash,format=3Draw,file=3Dpc-bios/edk2-aarch64-code.fd,readonly=3Don
-drive if=3Dpflash,format=3Draw,file=3Dpc-bios/edk2-arm-vars.fd,snapshot=3D=
on
-cdrom tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2
-cpu cortex-a57 -chardev
socket,id=3Dchr,path=3D/tmp/qemu-test_acpi_virt_tcg_crb-device.KZ3GE2/sock
-tpmdev emulator,id=3Ddev,chardev=3Dchr -device tpm-crb-device,tpmdev=3Ddev
-accel qtest
Warning! zero length expected file 'tests/data/acpi/virt/TPM2.crb-device.tp=
m2'
Warning! zero length expected file 'tests/data/acpi/virt/DSDT.crb-device.tp=
m2'
acpi-test: Warning!  binary file mismatch. Actual
[aml:/tmp/aml-GO4ME2], Expected
[aml:tests/data/acpi/virt/TPM2.crb-device.tpm2].
See source file tests/qtest/bios-tables-test.c for instructions on how
to update expected files.
acpi-test: Warning!  binary file mismatch. Actual
[aml:/tmp/aml-6N4ME2], Expected
[aml:tests/data/acpi/virt/DSDT.crb-device.tpm2].
See source file tests/qtest/bios-tables-test.c for instructions on how
to update expected files.
to see ASL diff between mismatched files install IASL, rebuild QEMU
from scratch and re-run tests with V=3D1 environment variable set**
ERROR:../tests/qtest/bios-tables-test.c:538:test_acpi_asl: assertion
failed: (all_tables_match)
not ok /aarch64/acpi/virt/tpm2-crb -
ERROR:../tests/qtest/bios-tables-test.c:538:test_acpi_asl: assertion
failed: (all_tables_match)
Bail out!
qemu-system-aarch64: tpm-emulator: Could not cleanly shutdown the TPM:
Resource temporarily unavailable
Unexpected error in qio_channel_socket_writev() at ../io/channel-socket.c:6=
22:
/home/elmarco/src/qemu/buildall/tests/qtest/bios-tables-test: Unable
to write to socket: Bad file descriptor

> ---
>  tests/qtest/bios-tables-test.c | 43 ++++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
> index 71af5cf69f..bb4ebf00c1 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1447,6 +1447,28 @@ static void test_acpi_piix4_tcg_numamem(void)
>
>  uint64_t tpm_tis_base_addr;
>
> +static test_data tcg_tpm_test_data(const char *machine)
> +{
> +    if (g_strcmp0(machine, "virt") =3D=3D 0) {
> +        test_data data =3D {
> +            .machine =3D "virt",
> +            .tcg_only =3D true,
> +            .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
> +            .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
> +            .cd =3D
> +               "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso=
.qcow2",
> +            .ram_start =3D 0x40000000ULL,
> +            .scan_len =3D 128ULL * 1024 * 1024,
> +        };
> +        return data;
> +    } else {
> +        test_data data =3D {
> +            .machine =3D machine,
> +        };
> +        return data;
> +    }
> +}
> +
>  static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
>                                uint64_t base, enum TPMVersion tpm_version=
)
>  {
> @@ -1454,7 +1476,7 @@ static void test_acpi_tcg_tpm(const char *machine, =
const char *tpm_if,
>                                            machine, tpm_if);
>      char *tmp_path =3D g_dir_make_tmp(tmp_dir_name, NULL);
>      TPMTestState test;
> -    test_data data =3D {};
> +    test_data data =3D tcg_tpm_test_data(machine);
>      GThread *thread;
>      const char *suffix =3D tpm_version =3D=3D TPM_VERSION_2_0 ? "tpm2" :=
 "tpm12";
>      char *args, *variant =3D g_strdup_printf(".%s.%s", tpm_if, suffix);
> @@ -1474,13 +1496,14 @@ static void test_acpi_tcg_tpm(const char *machine=
, const char *tpm_if,
>      thread =3D g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
>      tpm_emu_test_wait_cond(&test);
>
> -    data.machine =3D machine;
>      data.variant =3D variant;
>
>      args =3D g_strdup_printf(
> +        " %s"
>          " -chardev socket,id=3Dchr,path=3D%s"
>          " -tpmdev emulator,id=3Ddev,chardev=3Dchr"
>          " -device tpm-%s,tpmdev=3Ddev",
> +        g_strcmp0(machine, "virt") =3D=3D 0 ? "-cpu cortex-a57" : "",
>          test.addr->u.q_unix.path, tpm_if);
>
>      test_acpi_one(args, &data);
> @@ -1506,6 +1529,16 @@ static void test_acpi_q35_tcg_tpm12_tis(void)
>      test_acpi_tcg_tpm("q35", "tis", 0xFED40000, TPM_VERSION_1_2);
>  }
>
> +static void test_acpi_q35_tcg_tpm2_crb(void)
> +{
> +    test_acpi_tcg_tpm("q35", "crb", 0xFED40000, TPM_VERSION_2_0);
> +}
> +
> +static void test_acpi_virt_tcg_tpm2_crb(void)
> +{
> +    test_acpi_tcg_tpm("virt", "crb-device", 0xFED40000, TPM_VERSION_2_0)=
;
> +}
> +
>  static void test_acpi_tcg_dimm_pxm(const char *machine)
>  {
>      test_data data =3D {};
> @@ -2212,6 +2245,9 @@ int main(int argc, char *argv[])
>                  qtest_add_func("acpi/q35/tpm12-tis",
>                                 test_acpi_q35_tcg_tpm12_tis);
>              }
> +            if (tpm_model_is_available("-machine q35", "tpm-crb")) {
> +                qtest_add_func("acpi/q35/tpm2-crb", test_acpi_q35_tcg_tp=
m2_crb);
> +            }
>              qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
>              qtest_add_func("acpi/q35/no-acpi-hotplug",
>                             test_acpi_q35_tcg_no_acpi_hotplug);
> @@ -2301,6 +2337,9 @@ int main(int argc, char *argv[])
>                  qtest_add_func("acpi/virt/viot", test_acpi_virt_viot);
>              }
>          }
> +        if (tpm_model_is_available("-machine virt", "tpm-crb")) {
> +            qtest_add_func("acpi/virt/tpm2-crb", test_acpi_virt_tcg_tpm2=
_crb);
> +        }
>      }
>      ret =3D g_test_run();
>      boot_sector_cleanup(disk);
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

