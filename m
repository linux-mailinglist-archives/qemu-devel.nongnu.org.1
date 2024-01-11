Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D75F82B028
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:03:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvdv-0000KH-3I; Thu, 11 Jan 2024 09:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rNshv-0007va-M4
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 05:54:43 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rNshr-0007jb-Hq
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 05:54:43 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5585fe04266so1723017a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 02:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704970478; x=1705575278; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GRDrmEBybQOJb4KPjA+8oSoyI88aHZgrvOnHKm7WnAk=;
 b=gaYJ/1PMGM9Nq1jSx8XK/lgucStTJAERIeMD3tjm9U154Tgi0bI7QSBtv+sXNWKWJc
 /PbRzWrZIRg7bg0jy17Enh7SEt80uIs+FX+nzbjpd6iY7sCfxshlFqD9SCaASUh/gxbf
 SbbDTNkanAv9sxuWJblxjzwJOTAJQTpgMcJCUe0cDQ84xmThHuBX9EotKdWKar55l3oH
 o1xsA/1ecBTGqAIyOQOctlSo7xuvhukKsq2u+kHHeFI+0RLrDJa6aPEfCFT87V+yGrxt
 rHTp6RDS6yJI7fmBp7GBwzvtp3kd+J0r+NxgJPnsS4b0XjkCjpqWS4DpEpN2/L562YYg
 7Oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704970478; x=1705575278;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GRDrmEBybQOJb4KPjA+8oSoyI88aHZgrvOnHKm7WnAk=;
 b=QrLZ7D4I+O7BAvg7IIsJ1Ibs9u2G35Ctl/7QRuGEz98X6f8R0W2SHWEuPQMOvgDUwv
 WmRwLS0OJfs5qU+V7AO1bsqBzoNKzBSFOFQjSuo+KR78HHjqw1JiR+EP377ifDMpbNwD
 DWAF3AQVU2cZjZRkPK+p5Dc67bu4AyxqP53UEPxttlMYG+Dac+7JO1jPuhu8Ywj6bLCg
 vuo/berIEmxN9/YCQS/S+27JgmwzB61vdF5IHEmcz8FQ6Bg8E79y5VrI5C5depGLYhJf
 ZUXJ9u86dCR4QZPF4Gj45Xejb8WMToMpGUmwZ11bTySpeZQcrADTrSQwpPvxUqnjEY9x
 MgWA==
X-Gm-Message-State: AOJu0YzseqlfaooY2t/AfX4Bp7kA+wfUYp2dQUsKxZ3lPhhQ83cETfFY
 ABnEY7pCQizY1aDK/dXZwTLsUhC4h6R9AJQlrqAw9WFNyy5oIw==
X-Google-Smtp-Source: AGHT+IG6mqBiNLkJ1q4loFBI5JetFo2J0eDrC5AFbXdgh8iCLEgPzlUApC5a+A0+ANimUTXOYytLX7cbLsUGIGYrI6A=
X-Received: by 2002:a05:6402:3136:b0:557:df24:c15a with SMTP id
 dd22-20020a056402313600b00557df24c15amr498305edb.49.1704970477436; Thu, 11
 Jan 2024 02:54:37 -0800 (PST)
MIME-Version: 1.0
References: <20240111103924.698341-1-atp.exp@gmail.com>
In-Reply-To: <20240111103924.698341-1-atp.exp@gmail.com>
From: atp exp <atp.exp@gmail.com>
Date: Thu, 11 Jan 2024 10:54:25 +0000
Message-ID: <CAFgBtdHpLwPSO74mRtbYBry=8bmXd0Vys56aKjjsT=Qp0S5Rwg@mail.gmail.com>
Subject: Re: [PATCH v2] qemu-img: Fix Column Width and Improve Formatting in
 snapshot list
To: qemu-devel@nongnu.org, atp@tutamail.com
Cc: hreitz@redhat.com, kwolf@redhat.com
Content-Type: multipart/alternative; boundary="000000000000a901e8060ea95fb8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=atp.exp@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 11 Jan 2024 09:02:37 -0500
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

--000000000000a901e8060ea95fb8
Content-Type: text/plain; charset="UTF-8"

Changes from v2:
- Change email provider to 'gmail', to prevent auto-wrapping patches.
- Change more unit tests in
'tests/qemu-iotests/tests/qcow2-internal-snapshots.out'

On Thu, 11 Jan 2024 at 10:39, Abhiram Tilak <atp.exp@gmail.com> wrote:

> When running the command `qemu-img snapshot -l SNAPSHOT` the output of
> VM_CLOCK (measures the offset between host and VM clock) cannot to
> accommodate values in the order of thousands (4-digit).
>
> This line [1] hints on the problem. Additionally, the column width for
> the VM_CLOCK field was reduced from 15 to 13 spaces in commit b39847a5
> in line [2], resulting in a shortage of space.
>
> [1]:
> https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L753
> [2]:
> https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L763
>
> This patch restores the column width to 15 spaces and makes adjustments
> to the affected iotests accordingly. Furthermore, addresses a potential
> source
> of confusion by removing whitespace in column headers. Example, VM CLOCK
> is modified to VM_CLOCK. Additionally a '--' symbol is introduced when
> ICOUNT returns no output for clarity.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2062
> Fixes: b39847a50553 (migration: introduce icount field for snapshots )
> Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>
> ---
>  block/qapi.c                                  | 10 ++--
>  tests/qemu-iotests/267.out                    | 48 +++++++++----------
>  .../tests/qcow2-internal-snapshots.out        | 10 ++--
>  3 files changed, 35 insertions(+), 33 deletions(-)
>
> diff --git a/block/qapi.c b/block/qapi.c
> index 9e806fa230..500afc20c7 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -742,15 +742,15 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
>      char *sizing = NULL;
>
>      if (!sn) {
> -        qemu_printf("%-10s%-17s%8s%20s%13s%11s",
> -                    "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK", "ICOUNT");
> +        qemu_printf("%-10s%-17s%8s%20s%15s%11s",
> +                    "ID", "TAG", "VM_SIZE", "DATE", "VM_CLOCK", "ICOUNT");
>      } else {
>          g_autoptr(GDateTime) date =
> g_date_time_new_from_unix_local(sn->date_sec);
>          g_autofree char *date_buf = g_date_time_format(date, "%Y-%m-%d
> %H:%M:%S");
>
>          secs = sn->vm_clock_nsec / 1000000000;
>          snprintf(clock_buf, sizeof(clock_buf),
> -                 "%02d:%02d:%02d.%03d",
> +                 "%04d:%02d:%02d.%03d",
>                   (int)(secs / 3600),
>                   (int)((secs / 60) % 60),
>                   (int)(secs % 60),
> @@ -759,8 +759,10 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
>          if (sn->icount != -1ULL) {
>              snprintf(icount_buf, sizeof(icount_buf),
>                  "%"PRId64, sn->icount);
> +        } else {
> +            snprintf(icount_buf, sizeof(icount_buf), "--");
>          }
> -        qemu_printf("%-9s %-16s %8s%20s%13s%11s",
> +        qemu_printf("%-9s %-16s %8s%20s%15s%11s",
>                      sn->id_str, sn->name,
>                      sizing,
>                      date_buf,
> diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
> index 7176e376e1..21339e67ad 100644
> --- a/tests/qemu-iotests/267.out
> +++ b/tests/qemu-iotests/267.out
> @@ -33,8 +33,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK
>  ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID        TAG               VM_SIZE                DATE       VM_CLOCK
>  ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000
>      --
>  (qemu) loadvm snap0
>  (qemu) quit
>
> @@ -44,8 +44,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK
>  ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID        TAG               VM_SIZE                DATE       VM_CLOCK
>  ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000
>      --
>  (qemu) loadvm snap0
>  (qemu) quit
>
> @@ -69,8 +69,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK
>  ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID        TAG               VM_SIZE                DATE       VM_CLOCK
>  ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000
>      --
>  (qemu) loadvm snap0
>  (qemu) quit
>
> @@ -94,8 +94,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK
>  ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID        TAG               VM_SIZE                DATE       VM_CLOCK
>  ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000
>      --
>  (qemu) loadvm snap0
>  (qemu) quit
>
> @@ -105,8 +105,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK
>  ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID        TAG               VM_SIZE                DATE       VM_CLOCK
>  ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000
>      --
>  (qemu) loadvm snap0
>  (qemu) quit
>
> @@ -119,8 +119,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK
>  ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID        TAG               VM_SIZE                DATE       VM_CLOCK
>  ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000
>      --
>  (qemu) loadvm snap0
>  (qemu) quit
>
> @@ -134,8 +134,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK
>  ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID        TAG               VM_SIZE                DATE       VM_CLOCK
>  ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000
>      --
>  (qemu) loadvm snap0
>  (qemu) quit
>
> @@ -145,15 +145,15 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK
>  ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID        TAG               VM_SIZE                DATE       VM_CLOCK
>  ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000
>      --
>  (qemu) loadvm snap0
>  (qemu) quit
>
>  Internal snapshots on overlay:
>  Snapshot list:
> -ID        TAG               VM SIZE                DATE     VM CLOCK
>  ICOUNT
> -1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID        TAG               VM_SIZE                DATE       VM_CLOCK
>  ICOUNT
> +1         snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000
>      --
>  Internal snapshots on backing file:
>
>  === -blockdev with NBD server on the backing file ===
> @@ -166,17 +166,17 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK
>  ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID        TAG               VM_SIZE                DATE       VM_CLOCK
>  ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000
>      --
>  (qemu) loadvm snap0
>  (qemu) quit
>
>  Internal snapshots on overlay:
>  Snapshot list:
> -ID        TAG               VM SIZE                DATE     VM CLOCK
>  ICOUNT
> -1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID        TAG               VM_SIZE                DATE       VM_CLOCK
>  ICOUNT
> +1         snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000
>      --
>  Internal snapshots on backing file:
>  Snapshot list:
> -ID        TAG               VM SIZE                DATE     VM CLOCK
>  ICOUNT
> -1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID        TAG               VM_SIZE                DATE       VM_CLOCK
>  ICOUNT
> +1         snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000
>      --
>  *** done
> diff --git a/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
> b/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
> index 438f535e6a..c324131561 100644
> --- a/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
> +++ b/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
> @@ -14,8 +14,8 @@ wrote 524288/524288 bytes at offset 0
>  (qemu) quit
>
>  Snapshot list:
> -ID        TAG               VM SIZE                DATE     VM CLOCK
>  ICOUNT
> -1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID        TAG               VM_SIZE                DATE       VM_CLOCK
>  ICOUNT
> +1         snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000
>      --
>  No errors were found on the image.
>
>  === Verify that loading the snapshot reverts to the old content ===
> @@ -48,8 +48,8 @@ read 64512/64512 bytes at offset 66560
>
>  Snapshot list:
>  ID        TAG               VM SIZE                DATE     VM CLOCK
>  ICOUNT
> -1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> -2         snap1                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +1         snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000
>      --
> +2         snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000
>      --
>  No errors were found on the image.
>
>  === qemu-img snapshot can revert to snapshots ===
> @@ -80,7 +80,7 @@ read 64512/64512 bytes at offset 66560
>
>  Snapshot list:
>  ID        TAG               VM SIZE                DATE     VM CLOCK
>  ICOUNT
> -1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +1         snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000
>      --
>  No errors were found on the image.
>
>  === Error cases ===
> --
> 2.40.1
>

--000000000000a901e8060ea95fb8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5DaGFuZ2VzIGZyb20gdjI6wqA8L2Rpdj48ZGl2Pi0gQ2hhbmdl
IGVtYWlsIHByb3ZpZGVyIHRvICYjMzk7Z21haWwmIzM5OywgdG8gcHJldmVudCBhdXRvLXdyYXBw
aW5nIHBhdGNoZXMuPC9kaXY+PGRpdj4tIENoYW5nZSBtb3JlIHVuaXQgdGVzdHMgaW4gJiMzOTt0
ZXN0cy9xZW11LWlvdGVzdHMvdGVzdHMvcWNvdzItaW50ZXJuYWwtc25hcHNob3RzLm91dCYjMzk7
IDwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIg
Y2xhc3M9ImdtYWlsX2F0dHIiPk9uIFRodSwgMTEgSmFuIDIwMjQgYXQgMTA6MzksIEFiaGlyYW0g
VGlsYWsgJmx0OzxhIGhyZWY9Im1haWx0bzphdHAuZXhwQGdtYWlsLmNvbSI+YXRwLmV4cEBnbWFp
bC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1
b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xp
ZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPldoZW4gcnVubmluZyB0aGUgY29t
bWFuZCBgcWVtdS1pbWcgc25hcHNob3QgLWwgU05BUFNIT1RgIHRoZSBvdXRwdXQgb2Y8YnI+DQpW
TV9DTE9DSyAobWVhc3VyZXMgdGhlIG9mZnNldCBiZXR3ZWVuIGhvc3QgYW5kIFZNIGNsb2NrKSBj
YW5ub3QgdG88YnI+DQphY2NvbW1vZGF0ZSB2YWx1ZXMgaW4gdGhlIG9yZGVyIG9mIHRob3VzYW5k
cyAoNC1kaWdpdCkuPGJyPg0KPGJyPg0KVGhpcyBsaW5lIFsxXSBoaW50cyBvbiB0aGUgcHJvYmxl
bS4gQWRkaXRpb25hbGx5LCB0aGUgY29sdW1uIHdpZHRoIGZvcjxicj4NCnRoZSBWTV9DTE9DSyBm
aWVsZCB3YXMgcmVkdWNlZCBmcm9tIDE1IHRvIDEzIHNwYWNlcyBpbiBjb21taXQgYjM5ODQ3YTU8
YnI+DQppbiBsaW5lIFsyXSwgcmVzdWx0aW5nIGluIGEgc2hvcnRhZ2Ugb2Ygc3BhY2UuPGJyPg0K
PGJyPg0KWzFdOiA8YSBocmVmPSJodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUv
LS9ibG9iL21hc3Rlci9ibG9jay9xYXBpLmM/cmVmX3R5cGU9aGVhZHMjTDc1MyIgcmVsPSJub3Jl
ZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9x
ZW11Ly0vYmxvYi9tYXN0ZXIvYmxvY2svcWFwaS5jP3JlZl90eXBlPWhlYWRzI0w3NTM8L2E+PGJy
Pg0KWzJdOiA8YSBocmVmPSJodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS9i
bG9iL21hc3Rlci9ibG9jay9xYXBpLmM/cmVmX3R5cGU9aGVhZHMjTDc2MyIgcmVsPSJub3JlZmVy
cmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11
Ly0vYmxvYi9tYXN0ZXIvYmxvY2svcWFwaS5jP3JlZl90eXBlPWhlYWRzI0w3NjM8L2E+PGJyPg0K
PGJyPg0KVGhpcyBwYXRjaCByZXN0b3JlcyB0aGUgY29sdW1uIHdpZHRoIHRvIDE1IHNwYWNlcyBh
bmQgbWFrZXMgYWRqdXN0bWVudHM8YnI+DQp0byB0aGUgYWZmZWN0ZWQgaW90ZXN0cyBhY2NvcmRp
bmdseS4gRnVydGhlcm1vcmUsIGFkZHJlc3NlcyBhIHBvdGVudGlhbCBzb3VyY2U8YnI+DQpvZiBj
b25mdXNpb24gYnkgcmVtb3Zpbmcgd2hpdGVzcGFjZSBpbiBjb2x1bW4gaGVhZGVycy4gRXhhbXBs
ZSwgVk0gQ0xPQ0s8YnI+DQppcyBtb2RpZmllZCB0byBWTV9DTE9DSy4gQWRkaXRpb25hbGx5IGEg
JiMzOTstLSYjMzk7IHN5bWJvbCBpcyBpbnRyb2R1Y2VkIHdoZW48YnI+DQpJQ09VTlQgcmV0dXJu
cyBubyBvdXRwdXQgZm9yIGNsYXJpdHkuPGJyPg0KPGJyPg0KUmVzb2x2ZXM6IDxhIGhyZWY9Imh0
dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL2lzc3Vlcy8yMDYyIiByZWw9Im5v
cmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0
L3FlbXUvLS9pc3N1ZXMvMjA2MjwvYT48YnI+DQpGaXhlczogYjM5ODQ3YTUwNTUzIChtaWdyYXRp
b246IGludHJvZHVjZSBpY291bnQgZmllbGQgZm9yIHNuYXBzaG90cyApPGJyPg0KU2lnbmVkLW9m
Zi1ieTogQWJoaXJhbSBUaWxhayAmbHQ7PGEgaHJlZj0ibWFpbHRvOmF0cC5leHBAZ21haWwuY29t
IiB0YXJnZXQ9Il9ibGFuayI+YXRwLmV4cEBnbWFpbC5jb208L2E+Jmd0Ozxicj4NCi0tLTxicj4N
CsKgYmxvY2svcWFwaS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfCAxMCArKy0tPGJyPg0KwqB0ZXN0cy9xZW11LWlvdGVzdHMvMjY3Lm91dMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHwgNDggKysrKysrKysrLS0tLS0tLS0tLTxicj4NCsKg
Li4uL3Rlc3RzL3Fjb3cyLWludGVybmFsLXNuYXBzaG90cy5vdXTCoCDCoCDCoCDCoCB8IDEwICsr
LS08YnI+DQrCoDMgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25z
KC0pPGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2Jsb2NrL3FhcGkuYyBiL2Jsb2NrL3FhcGkuYzxi
cj4NCmluZGV4IDllODA2ZmEyMzAuLjUwMGFmYzIwYzcgMTAwNjQ0PGJyPg0KLS0tIGEvYmxvY2sv
cWFwaS5jPGJyPg0KKysrIGIvYmxvY2svcWFwaS5jPGJyPg0KQEAgLTc0MiwxNSArNzQyLDE1IEBA
IHZvaWQgYmRydl9zbmFwc2hvdF9kdW1wKFFFTVVTbmFwc2hvdEluZm8gKnNuKTxicj4NCsKgIMKg
IMKgY2hhciAqc2l6aW5nID0gTlVMTDs8YnI+DQo8YnI+DQrCoCDCoCDCoGlmICghc24pIHs8YnI+
DQotwqAgwqAgwqAgwqAgcWVtdV9wcmludGYoJnF1b3Q7JS0xMHMlLTE3cyU4cyUyMHMlMTNzJTEx
cyZxdW90Oyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7SUQmcXVv
dDssICZxdW90O1RBRyZxdW90OywgJnF1b3Q7Vk0gU0laRSZxdW90OywgJnF1b3Q7REFURSZxdW90
OywgJnF1b3Q7Vk0gQ0xPQ0smcXVvdDssICZxdW90O0lDT1VOVCZxdW90Oyk7PGJyPg0KK8KgIMKg
IMKgIMKgIHFlbXVfcHJpbnRmKCZxdW90OyUtMTBzJS0xN3MlOHMlMjBzJTE1cyUxMXMmcXVvdDss
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O0lEJnF1b3Q7LCAmcXVv
dDtUQUcmcXVvdDssICZxdW90O1ZNX1NJWkUmcXVvdDssICZxdW90O0RBVEUmcXVvdDssICZxdW90
O1ZNX0NMT0NLJnF1b3Q7LCAmcXVvdDtJQ09VTlQmcXVvdDspOzxicj4NCsKgIMKgIMKgfSBlbHNl
IHs8YnI+DQrCoCDCoCDCoCDCoCDCoGdfYXV0b3B0cihHRGF0ZVRpbWUpIGRhdGUgPSBnX2RhdGVf
dGltZV9uZXdfZnJvbV91bml4X2xvY2FsKHNuLSZndDtkYXRlX3NlYyk7PGJyPg0KwqAgwqAgwqAg
wqAgwqBnX2F1dG9mcmVlIGNoYXIgKmRhdGVfYnVmID0gZ19kYXRlX3RpbWVfZm9ybWF0KGRhdGUs
ICZxdW90OyVZLSVtLSVkICVIOiVNOiVTJnF1b3Q7KTs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDC
oHNlY3MgPSBzbi0mZ3Q7dm1fY2xvY2tfbnNlYyAvIDEwMDAwMDAwMDA7PGJyPg0KwqAgwqAgwqAg
wqAgwqBzbnByaW50ZihjbG9ja19idWYsIHNpemVvZihjbG9ja19idWYpLDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90OyUwMmQ6JTAyZDolMDJkLiUwM2QmcXVvdDssPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7JTA0ZDolMDJkOiUwMmQuJTAzZCZxdW90
Oyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAoaW50KShzZWNzIC8gMzYwMCksPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKGludCkoKHNlY3MgLyA2MCkgJSA2MCksPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKGludCkoc2VjcyAlIDYwKSw8YnI+DQpAQCAt
NzU5LDggKzc1OSwxMCBAQCB2b2lkIGJkcnZfc25hcHNob3RfZHVtcChRRU1VU25hcHNob3RJbmZv
ICpzbik8YnI+DQrCoCDCoCDCoCDCoCDCoGlmIChzbi0mZ3Q7aWNvdW50ICE9IC0xVUxMKSB7PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqBzbnByaW50ZihpY291bnRfYnVmLCBzaXplb2YoaWNvdW50
X2J1ZiksPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDslJnF1b3Q7UFJJZDY0
LCBzbi0mZ3Q7aWNvdW50KTs8YnI+DQorwqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgc25wcmludGYoaWNvdW50X2J1Ziwgc2l6ZW9mKGljb3VudF9idWYpLCAmcXVv
dDstLSZxdW90Oyk7PGJyPg0KwqAgwqAgwqAgwqAgwqB9PGJyPg0KLcKgIMKgIMKgIMKgIHFlbXVf
cHJpbnRmKCZxdW90OyUtOXMgJS0xNnMgJThzJTIwcyUxM3MlMTFzJnF1b3Q7LDxicj4NCivCoCDC
oCDCoCDCoCBxZW11X3ByaW50ZigmcXVvdDslLTlzICUtMTZzICU4cyUyMHMlMTVzJTExcyZxdW90
Oyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNuLSZndDtpZF9zdHIsIHNu
LSZndDtuYW1lLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2l6aW5nLDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGF0ZV9idWYsPGJyPg0KZGlmZiAt
LWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNjcub3V0IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI2
Ny5vdXQ8YnI+DQppbmRleCA3MTc2ZTM3NmUxLi4yMTMzOWU2N2FkIDEwMDY0NDxicj4NCi0tLSBh
L3Rlc3RzL3FlbXUtaW90ZXN0cy8yNjcub3V0PGJyPg0KKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3Rz
LzI2Ny5vdXQ8YnI+DQpAQCAtMzMsOCArMzMsOCBAQCBRRU1VIFguWS5aIG1vbml0b3IgLSB0eXBl
ICYjMzk7aGVscCYjMzk7IGZvciBtb3JlIGluZm9ybWF0aW9uPGJyPg0KwqAocWVtdSkgc2F2ZXZt
IHNuYXAwPGJyPg0KwqAocWVtdSkgaW5mbyBzbmFwc2hvdHM8YnI+DQrCoExpc3Qgb2Ygc25hcHNo
b3RzIHByZXNlbnQgb24gYWxsIGRpc2tzOjxicj4NCi1JRMKgIMKgIMKgIMKgIFRBR8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgVk0gU0laRcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIERBVEXCoCDCoCDC
oFZNIENMT0NLwqAgwqAgwqBJQ09VTlQ8YnI+DQotLS3CoCDCoCDCoCDCoCBzbmFwMMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFNJWkUgeXl5eS1tbS1kZCBoaDptbTpzcyAwMDowMDowMC4wMDA8YnI+
DQorSUTCoCDCoCDCoCDCoCBUQUfCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFZNX1NJWkXCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBEQVRFwqAgwqAgwqAgwqBWTV9DTE9DS8KgIMKgIMKgSUNPVU5UPGJy
Pg0KKy0twqAgwqAgwqAgwqAgc25hcDDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBTSVpFIHl5eXkt
bW0tZGQgaGg6bW06c3MgMDAwMDowMDowMC4wMDDCoCDCoCDCoCDCoCDCoC0tPGJyPg0KwqAocWVt
dSkgbG9hZHZtIHNuYXAwPGJyPg0KwqAocWVtdSkgcXVpdDxicj4NCjxicj4NCkBAIC00NCw4ICs0
NCw4IEBAIFFFTVUgWC5ZLlogbW9uaXRvciAtIHR5cGUgJiMzOTtoZWxwJiMzOTsgZm9yIG1vcmUg
aW5mb3JtYXRpb248YnI+DQrCoChxZW11KSBzYXZldm0gc25hcDA8YnI+DQrCoChxZW11KSBpbmZv
IHNuYXBzaG90czxicj4NCsKgTGlzdCBvZiBzbmFwc2hvdHMgcHJlc2VudCBvbiBhbGwgZGlza3M6
PGJyPg0KLUlEwqAgwqAgwqAgwqAgVEFHwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBWTSBTSVpFwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgREFURcKgIMKgIMKgVk0gQ0xPQ0vCoCDCoCDCoElDT1VOVDxi
cj4NCi0tLcKgIMKgIMKgIMKgIHNuYXAwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgU0laRSB5eXl5
LW1tLWRkIGhoOm1tOnNzIDAwOjAwOjAwLjAwMDxicj4NCitJRMKgIMKgIMKgIMKgIFRBR8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgVk1fU0laRcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIERBVEXCoCDC
oCDCoCDCoFZNX0NMT0NLwqAgwqAgwqBJQ09VTlQ8YnI+DQorLS3CoCDCoCDCoCDCoCBzbmFwMMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFNJWkUgeXl5eS1tbS1kZCBoaDptbTpzcyAwMDAwOjAwOjAw
LjAwMMKgIMKgIMKgIMKgIMKgLS08YnI+DQrCoChxZW11KSBsb2Fkdm0gc25hcDA8YnI+DQrCoChx
ZW11KSBxdWl0PGJyPg0KPGJyPg0KQEAgLTY5LDggKzY5LDggQEAgUUVNVSBYLlkuWiBtb25pdG9y
IC0gdHlwZSAmIzM5O2hlbHAmIzM5OyBmb3IgbW9yZSBpbmZvcm1hdGlvbjxicj4NCsKgKHFlbXUp
IHNhdmV2bSBzbmFwMDxicj4NCsKgKHFlbXUpIGluZm8gc25hcHNob3RzPGJyPg0KwqBMaXN0IG9m
IHNuYXBzaG90cyBwcmVzZW50IG9uIGFsbCBkaXNrczo8YnI+DQotSUTCoCDCoCDCoCDCoCBUQUfC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoFZNIFNJWkXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBEQVRF
wqAgwqAgwqBWTSBDTE9DS8KgIMKgIMKgSUNPVU5UPGJyPg0KLS0twqAgwqAgwqAgwqAgc25hcDDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBTSVpFIHl5eXktbW0tZGQgaGg6bW06c3MgMDA6MDA6MDAu
MDAwPGJyPg0KK0lEwqAgwqAgwqAgwqAgVEFHwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBWTV9TSVpF
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgREFURcKgIMKgIMKgIMKgVk1fQ0xPQ0vCoCDCoCDCoElD
T1VOVDxicj4NCistLcKgIMKgIMKgIMKgIHNuYXAwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgU0la
RSB5eXl5LW1tLWRkIGhoOm1tOnNzIDAwMDA6MDA6MDAuMDAwwqAgwqAgwqAgwqAgwqAtLTxicj4N
CsKgKHFlbXUpIGxvYWR2bSBzbmFwMDxicj4NCsKgKHFlbXUpIHF1aXQ8YnI+DQo8YnI+DQpAQCAt
OTQsOCArOTQsOCBAQCBRRU1VIFguWS5aIG1vbml0b3IgLSB0eXBlICYjMzk7aGVscCYjMzk7IGZv
ciBtb3JlIGluZm9ybWF0aW9uPGJyPg0KwqAocWVtdSkgc2F2ZXZtIHNuYXAwPGJyPg0KwqAocWVt
dSkgaW5mbyBzbmFwc2hvdHM8YnI+DQrCoExpc3Qgb2Ygc25hcHNob3RzIHByZXNlbnQgb24gYWxs
IGRpc2tzOjxicj4NCi1JRMKgIMKgIMKgIMKgIFRBR8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVk0g
U0laRcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIERBVEXCoCDCoCDCoFZNIENMT0NLwqAgwqAgwqBJ
Q09VTlQ8YnI+DQotLS3CoCDCoCDCoCDCoCBzbmFwMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFNJ
WkUgeXl5eS1tbS1kZCBoaDptbTpzcyAwMDowMDowMC4wMDA8YnI+DQorSUTCoCDCoCDCoCDCoCBU
QUfCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFZNX1NJWkXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBE
QVRFwqAgwqAgwqAgwqBWTV9DTE9DS8KgIMKgIMKgSUNPVU5UPGJyPg0KKy0twqAgwqAgwqAgwqAg
c25hcDDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBTSVpFIHl5eXktbW0tZGQgaGg6bW06c3MgMDAw
MDowMDowMC4wMDDCoCDCoCDCoCDCoCDCoC0tPGJyPg0KwqAocWVtdSkgbG9hZHZtIHNuYXAwPGJy
Pg0KwqAocWVtdSkgcXVpdDxicj4NCjxicj4NCkBAIC0xMDUsOCArMTA1LDggQEAgUUVNVSBYLlku
WiBtb25pdG9yIC0gdHlwZSAmIzM5O2hlbHAmIzM5OyBmb3IgbW9yZSBpbmZvcm1hdGlvbjxicj4N
CsKgKHFlbXUpIHNhdmV2bSBzbmFwMDxicj4NCsKgKHFlbXUpIGluZm8gc25hcHNob3RzPGJyPg0K
wqBMaXN0IG9mIHNuYXBzaG90cyBwcmVzZW50IG9uIGFsbCBkaXNrczo8YnI+DQotSUTCoCDCoCDC
oCDCoCBUQUfCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFZNIFNJWkXCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBEQVRFwqAgwqAgwqBWTSBDTE9DS8KgIMKgIMKgSUNPVU5UPGJyPg0KLS0twqAgwqAgwqAg
wqAgc25hcDDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBTSVpFIHl5eXktbW0tZGQgaGg6bW06c3Mg
MDA6MDA6MDAuMDAwPGJyPg0KK0lEwqAgwqAgwqAgwqAgVEFHwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBWTV9TSVpFwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgREFURcKgIMKgIMKgIMKgVk1fQ0xPQ0vC
oCDCoCDCoElDT1VOVDxicj4NCistLcKgIMKgIMKgIMKgIHNuYXAwwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgU0laRSB5eXl5LW1tLWRkIGhoOm1tOnNzIDAwMDA6MDA6MDAuMDAwwqAgwqAgwqAgwqAg
wqAtLTxicj4NCsKgKHFlbXUpIGxvYWR2bSBzbmFwMDxicj4NCsKgKHFlbXUpIHF1aXQ8YnI+DQo8
YnI+DQpAQCAtMTE5LDggKzExOSw4IEBAIFFFTVUgWC5ZLlogbW9uaXRvciAtIHR5cGUgJiMzOTto
ZWxwJiMzOTsgZm9yIG1vcmUgaW5mb3JtYXRpb248YnI+DQrCoChxZW11KSBzYXZldm0gc25hcDA8
YnI+DQrCoChxZW11KSBpbmZvIHNuYXBzaG90czxicj4NCsKgTGlzdCBvZiBzbmFwc2hvdHMgcHJl
c2VudCBvbiBhbGwgZGlza3M6PGJyPg0KLUlEwqAgwqAgwqAgwqAgVEFHwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBWTSBTSVpFwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgREFURcKgIMKgIMKgVk0gQ0xP
Q0vCoCDCoCDCoElDT1VOVDxicj4NCi0tLcKgIMKgIMKgIMKgIHNuYXAwwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgU0laRSB5eXl5LW1tLWRkIGhoOm1tOnNzIDAwOjAwOjAwLjAwMDxicj4NCitJRMKg
IMKgIMKgIMKgIFRBR8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVk1fU0laRcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIERBVEXCoCDCoCDCoCDCoFZNX0NMT0NLwqAgwqAgwqBJQ09VTlQ8YnI+DQorLS3C
oCDCoCDCoCDCoCBzbmFwMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFNJWkUgeXl5eS1tbS1kZCBo
aDptbTpzcyAwMDAwOjAwOjAwLjAwMMKgIMKgIMKgIMKgIMKgLS08YnI+DQrCoChxZW11KSBsb2Fk
dm0gc25hcDA8YnI+DQrCoChxZW11KSBxdWl0PGJyPg0KPGJyPg0KQEAgLTEzNCw4ICsxMzQsOCBA
QCBRRU1VIFguWS5aIG1vbml0b3IgLSB0eXBlICYjMzk7aGVscCYjMzk7IGZvciBtb3JlIGluZm9y
bWF0aW9uPGJyPg0KwqAocWVtdSkgc2F2ZXZtIHNuYXAwPGJyPg0KwqAocWVtdSkgaW5mbyBzbmFw
c2hvdHM8YnI+DQrCoExpc3Qgb2Ygc25hcHNob3RzIHByZXNlbnQgb24gYWxsIGRpc2tzOjxicj4N
Ci1JRMKgIMKgIMKgIMKgIFRBR8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVk0gU0laRcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIERBVEXCoCDCoCDCoFZNIENMT0NLwqAgwqAgwqBJQ09VTlQ8YnI+DQot
LS3CoCDCoCDCoCDCoCBzbmFwMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFNJWkUgeXl5eS1tbS1k
ZCBoaDptbTpzcyAwMDowMDowMC4wMDA8YnI+DQorSUTCoCDCoCDCoCDCoCBUQUfCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoFZNX1NJWkXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBEQVRFwqAgwqAgwqAg
wqBWTV9DTE9DS8KgIMKgIMKgSUNPVU5UPGJyPg0KKy0twqAgwqAgwqAgwqAgc25hcDDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBTSVpFIHl5eXktbW0tZGQgaGg6bW06c3MgMDAwMDowMDowMC4wMDDC
oCDCoCDCoCDCoCDCoC0tPGJyPg0KwqAocWVtdSkgbG9hZHZtIHNuYXAwPGJyPg0KwqAocWVtdSkg
cXVpdDxicj4NCjxicj4NCkBAIC0xNDUsMTUgKzE0NSwxNSBAQCBRRU1VIFguWS5aIG1vbml0b3Ig
LSB0eXBlICYjMzk7aGVscCYjMzk7IGZvciBtb3JlIGluZm9ybWF0aW9uPGJyPg0KwqAocWVtdSkg
c2F2ZXZtIHNuYXAwPGJyPg0KwqAocWVtdSkgaW5mbyBzbmFwc2hvdHM8YnI+DQrCoExpc3Qgb2Yg
c25hcHNob3RzIHByZXNlbnQgb24gYWxsIGRpc2tzOjxicj4NCi1JRMKgIMKgIMKgIMKgIFRBR8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgVk0gU0laRcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIERBVEXC
oCDCoCDCoFZNIENMT0NLwqAgwqAgwqBJQ09VTlQ8YnI+DQotLS3CoCDCoCDCoCDCoCBzbmFwMMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFNJWkUgeXl5eS1tbS1kZCBoaDptbTpzcyAwMDowMDowMC4w
MDA8YnI+DQorSUTCoCDCoCDCoCDCoCBUQUfCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFZNX1NJWkXC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBEQVRFwqAgwqAgwqAgwqBWTV9DTE9DS8KgIMKgIMKgSUNP
VU5UPGJyPg0KKy0twqAgwqAgwqAgwqAgc25hcDDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBTSVpF
IHl5eXktbW0tZGQgaGg6bW06c3MgMDAwMDowMDowMC4wMDDCoCDCoCDCoCDCoCDCoC0tPGJyPg0K
wqAocWVtdSkgbG9hZHZtIHNuYXAwPGJyPg0KwqAocWVtdSkgcXVpdDxicj4NCjxicj4NCsKgSW50
ZXJuYWwgc25hcHNob3RzIG9uIG92ZXJsYXk6PGJyPg0KwqBTbmFwc2hvdCBsaXN0Ojxicj4NCi1J
RMKgIMKgIMKgIMKgIFRBR8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVk0gU0laRcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIERBVEXCoCDCoCDCoFZNIENMT0NLwqAgwqAgwqBJQ09VTlQ8YnI+DQotMcKg
IMKgIMKgIMKgIMKgc25hcDDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBTSVpFIHl5eXktbW0tZGQg
aGg6bW06c3MgMDA6MDA6MDAuMDAwPGJyPg0KK0lEwqAgwqAgwqAgwqAgVEFHwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBWTV9TSVpFwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgREFURcKgIMKgIMKgIMKg
Vk1fQ0xPQ0vCoCDCoCDCoElDT1VOVDxicj4NCisxwqAgwqAgwqAgwqAgwqBzbmFwMMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFNJWkUgeXl5eS1tbS1kZCBoaDptbTpzcyAwMDAwOjAwOjAwLjAwMMKg
IMKgIMKgIMKgIMKgLS08YnI+DQrCoEludGVybmFsIHNuYXBzaG90cyBvbiBiYWNraW5nIGZpbGU6
PGJyPg0KPGJyPg0KwqA9PT0gLWJsb2NrZGV2IHdpdGggTkJEIHNlcnZlciBvbiB0aGUgYmFja2lu
ZyBmaWxlID09PTxicj4NCkBAIC0xNjYsMTcgKzE2NiwxNyBAQCBRRU1VIFguWS5aIG1vbml0b3Ig
LSB0eXBlICYjMzk7aGVscCYjMzk7IGZvciBtb3JlIGluZm9ybWF0aW9uPGJyPg0KwqAocWVtdSkg
c2F2ZXZtIHNuYXAwPGJyPg0KwqAocWVtdSkgaW5mbyBzbmFwc2hvdHM8YnI+DQrCoExpc3Qgb2Yg
c25hcHNob3RzIHByZXNlbnQgb24gYWxsIGRpc2tzOjxicj4NCi1JRMKgIMKgIMKgIMKgIFRBR8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgVk0gU0laRcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIERBVEXC
oCDCoCDCoFZNIENMT0NLwqAgwqAgwqBJQ09VTlQ8YnI+DQotLS3CoCDCoCDCoCDCoCBzbmFwMMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFNJWkUgeXl5eS1tbS1kZCBoaDptbTpzcyAwMDowMDowMC4w
MDA8YnI+DQorSUTCoCDCoCDCoCDCoCBUQUfCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFZNX1NJWkXC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBEQVRFwqAgwqAgwqAgwqBWTV9DTE9DS8KgIMKgIMKgSUNP
VU5UPGJyPg0KKy0twqAgwqAgwqAgwqAgc25hcDDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBTSVpF
IHl5eXktbW0tZGQgaGg6bW06c3MgMDAwMDowMDowMC4wMDDCoCDCoCDCoCDCoCDCoC0tPGJyPg0K
wqAocWVtdSkgbG9hZHZtIHNuYXAwPGJyPg0KwqAocWVtdSkgcXVpdDxicj4NCjxicj4NCsKgSW50
ZXJuYWwgc25hcHNob3RzIG9uIG92ZXJsYXk6PGJyPg0KwqBTbmFwc2hvdCBsaXN0Ojxicj4NCi1J
RMKgIMKgIMKgIMKgIFRBR8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVk0gU0laRcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIERBVEXCoCDCoCDCoFZNIENMT0NLwqAgwqAgwqBJQ09VTlQ8YnI+DQotMcKg
IMKgIMKgIMKgIMKgc25hcDDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBTSVpFIHl5eXktbW0tZGQg
aGg6bW06c3MgMDA6MDA6MDAuMDAwPGJyPg0KK0lEwqAgwqAgwqAgwqAgVEFHwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBWTV9TSVpFwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgREFURcKgIMKgIMKgIMKg
Vk1fQ0xPQ0vCoCDCoCDCoElDT1VOVDxicj4NCisxwqAgwqAgwqAgwqAgwqBzbmFwMMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFNJWkUgeXl5eS1tbS1kZCBoaDptbTpzcyAwMDAwOjAwOjAwLjAwMMKg
IMKgIMKgIMKgIMKgLS08YnI+DQrCoEludGVybmFsIHNuYXBzaG90cyBvbiBiYWNraW5nIGZpbGU6
PGJyPg0KwqBTbmFwc2hvdCBsaXN0Ojxicj4NCi1JRMKgIMKgIMKgIMKgIFRBR8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgVk0gU0laRcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIERBVEXCoCDCoCDCoFZN
IENMT0NLwqAgwqAgwqBJQ09VTlQ8YnI+DQotMcKgIMKgIMKgIMKgIMKgc25hcDDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBTSVpFIHl5eXktbW0tZGQgaGg6bW06c3MgMDA6MDA6MDAuMDAwPGJyPg0K
K0lEwqAgwqAgwqAgwqAgVEFHwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBWTV9TSVpFwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgREFURcKgIMKgIMKgIMKgVk1fQ0xPQ0vCoCDCoCDCoElDT1VOVDxicj4N
CisxwqAgwqAgwqAgwqAgwqBzbmFwMMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFNJWkUgeXl5eS1t
bS1kZCBoaDptbTpzcyAwMDAwOjAwOjAwLjAwMMKgIMKgIMKgIMKgIMKgLS08YnI+DQrCoCoqKiBk
b25lPGJyPg0KZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy90ZXN0cy9xY293Mi1pbnRl
cm5hbC1zbmFwc2hvdHMub3V0IGIvdGVzdHMvcWVtdS1pb3Rlc3RzL3Rlc3RzL3Fjb3cyLWludGVy
bmFsLXNuYXBzaG90cy5vdXQ8YnI+DQppbmRleCA0MzhmNTM1ZTZhLi5jMzI0MTMxNTYxIDEwMDY0
NDxicj4NCi0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy90ZXN0cy9xY293Mi1pbnRlcm5hbC1zbmFw
c2hvdHMub3V0PGJyPg0KKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL3Rlc3RzL3Fjb3cyLWludGVy
bmFsLXNuYXBzaG90cy5vdXQ8YnI+DQpAQCAtMTQsOCArMTQsOCBAQCB3cm90ZSA1MjQyODgvNTI0
Mjg4IGJ5dGVzIGF0IG9mZnNldCAwPGJyPg0KwqAocWVtdSkgcXVpdDxicj4NCjxicj4NCsKgU25h
cHNob3QgbGlzdDo8YnI+DQotSUTCoCDCoCDCoCDCoCBUQUfCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oFZNIFNJWkXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBEQVRFwqAgwqAgwqBWTSBDTE9DS8KgIMKg
IMKgSUNPVU5UPGJyPg0KLTHCoCDCoCDCoCDCoCDCoHNuYXAwwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgU0laRSB5eXl5LW1tLWRkIGhoOm1tOnNzIDAwOjAwOjAwLjAwMDxicj4NCitJRMKgIMKgIMKg
IMKgIFRBR8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVk1fU0laRcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIERBVEXCoCDCoCDCoCDCoFZNX0NMT0NLwqAgwqAgwqBJQ09VTlQ8YnI+DQorMcKgIMKgIMKg
IMKgIMKgc25hcDDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBTSVpFIHl5eXktbW0tZGQgaGg6bW06
c3MgMDAwMDowMDowMC4wMDDCoCDCoCDCoCDCoCDCoC0tPGJyPg0KwqBObyBlcnJvcnMgd2VyZSBm
b3VuZCBvbiB0aGUgaW1hZ2UuPGJyPg0KPGJyPg0KwqA9PT0gVmVyaWZ5IHRoYXQgbG9hZGluZyB0
aGUgc25hcHNob3QgcmV2ZXJ0cyB0byB0aGUgb2xkIGNvbnRlbnQgPT09PGJyPg0KQEAgLTQ4LDgg
KzQ4LDggQEAgcmVhZCA2NDUxMi82NDUxMiBieXRlcyBhdCBvZmZzZXQgNjY1NjA8YnI+DQo8YnI+
DQrCoFNuYXBzaG90IGxpc3Q6PGJyPg0KwqBJRMKgIMKgIMKgIMKgIFRBR8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgVk0gU0laRcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIERBVEXCoCDCoCDCoFZNIENM
T0NLwqAgwqAgwqBJQ09VTlQ8YnI+DQotMcKgIMKgIMKgIMKgIMKgc25hcDDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBTSVpFIHl5eXktbW0tZGQgaGg6bW06c3MgMDA6MDA6MDAuMDAwPGJyPg0KLTLC
oCDCoCDCoCDCoCDCoHNuYXAxwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgU0laRSB5eXl5LW1tLWRk
IGhoOm1tOnNzIDAwOjAwOjAwLjAwMDxicj4NCisxwqAgwqAgwqAgwqAgwqBzbmFwMMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFNJWkUgeXl5eS1tbS1kZCBoaDptbTpzcyAwMDAwOjAwOjAwLjAwMMKg
IMKgIMKgIMKgIMKgLS08YnI+DQorMsKgIMKgIMKgIMKgIMKgc25hcDDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBTSVpFIHl5eXktbW0tZGQgaGg6bW06c3MgMDAwMDowMDowMC4wMDDCoCDCoCDCoCDC
oCDCoC0tPGJyPg0KwqBObyBlcnJvcnMgd2VyZSBmb3VuZCBvbiB0aGUgaW1hZ2UuPGJyPg0KPGJy
Pg0KwqA9PT0gcWVtdS1pbWcgc25hcHNob3QgY2FuIHJldmVydCB0byBzbmFwc2hvdHMgPT09PGJy
Pg0KQEAgLTgwLDcgKzgwLDcgQEAgcmVhZCA2NDUxMi82NDUxMiBieXRlcyBhdCBvZmZzZXQgNjY1
NjA8YnI+DQo8YnI+DQrCoFNuYXBzaG90IGxpc3Q6PGJyPg0KwqBJRMKgIMKgIMKgIMKgIFRBR8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgVk0gU0laRcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIERBVEXC
oCDCoCDCoFZNIENMT0NLwqAgwqAgwqBJQ09VTlQ8YnI+DQotMcKgIMKgIMKgIMKgIMKgc25hcDDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBTSVpFIHl5eXktbW0tZGQgaGg6bW06c3MgMDA6MDA6MDAu
MDAwPGJyPg0KKzHCoCDCoCDCoCDCoCDCoHNuYXAwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgU0la
RSB5eXl5LW1tLWRkIGhoOm1tOnNzIDAwMDA6MDA6MDAuMDAwwqAgwqAgwqAgwqAgwqAtLTxicj4N
CsKgTm8gZXJyb3JzIHdlcmUgZm91bmQgb24gdGhlIGltYWdlLjxicj4NCjxicj4NCsKgPT09IEVy
cm9yIGNhc2VzID09PTxicj4NCi0tPGJyPg0KMi40MC4xPGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2
Pg0K
--000000000000a901e8060ea95fb8--

