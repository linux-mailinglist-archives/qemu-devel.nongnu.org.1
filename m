Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3D0BF67C5
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 14:41:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBBey-0000Yg-Ki; Tue, 21 Oct 2025 08:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBBen-0000YI-PH; Tue, 21 Oct 2025 08:40:06 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBBeh-0006RV-EJ; Tue, 21 Oct 2025 08:40:04 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 765475972E3;
 Tue, 21 Oct 2025 14:39:52 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id y6qXkYk8AgZa; Tue, 21 Oct 2025 14:39:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 73FB15972DE; Tue, 21 Oct 2025 14:39:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 724315972E2;
 Tue, 21 Oct 2025 14:39:50 +0200 (CEST)
Date: Tue, 21 Oct 2025 14:39:50 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Vishal Chourasia <vishalc@linux.ibm.com>
cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com, 
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com, 
 hpoussin@reactos.org
Subject: Re: [Patch v5 6/6] hw/ppc: Pass errp to load_image_targphys() and
 report errors
In-Reply-To: <20251021105442.1474602-11-vishalc@linux.ibm.com>
Message-ID: <86222acd-6ccd-b833-84da-8851f5cb29f2@eik.bme.hu>
References: <20251021105442.1474602-2-vishalc@linux.ibm.com>
 <20251021105442.1474602-11-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Tue, 21 Oct 2025, Vishal Chourasia wrote:
> Pass errp to load_image_targphys() calls in ppc machine initialization
> to capture detailed error information when loading firmware, kernel,
> and initrd images.
>
> Use error_reportf_err() instead of error_report() to print the
> underlying error details along with context about which image failed
> to load.
>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
> hw/ppc/amigaone.c      | 15 ++++++++-------
> hw/ppc/e500.c          | 17 +++++++++--------
> hw/ppc/mac_newworld.c  | 25 +++++++++++++++----------
> hw/ppc/mac_oldworld.c  | 25 +++++++++++++++----------
> hw/ppc/pegasos2.c      | 17 +++++++++++------
> hw/ppc/pnv.c           | 31 ++++++++++++++-----------------
> hw/ppc/ppc440_bamboo.c |  9 +++++----
> hw/ppc/prep.c          | 25 +++++++++++++++----------
> hw/ppc/sam460ex.c      |  9 +++++----
> hw/ppc/spapr.c         | 15 ++++++++-------
> hw/ppc/virtex_ml507.c  | 17 +++++++++++------
> 11 files changed, 116 insertions(+), 89 deletions(-)
>
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 5c5acc9872..bd14bed243 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -276,6 +276,7 @@ static void amigaone_init(MachineState *machine)
>     DriveInfo *di;
>     hwaddr loadaddr;
>     struct boot_info *bi = NULL;
> +    Error *errp = NULL;
>
>     /* init CPU */
>     cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
> @@ -324,9 +325,9 @@ static void amigaone_init(MachineState *machine)
>             error_report("Could not find firmware '%s'", machine->firmware);
>             exit(1);
>         }
> -        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE, NULL);
> -        if (sz <= 0 || sz > PROM_SIZE) {
> -            error_report("Could not load firmware '%s'", filename);
> +        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE, &errp);
> +        if (errp) {
> +            error_reportf_err(errp, "Could not load firmware '%s': ", filename);
>             exit(1);

If all that's done with an errp is checking for error, printing it and 
then exit then isn't that what passing &error_fatal is for? So these 
should all just do that instead of open coding it, don't they? This would 
lose the general local error messages and those would be replaced by the 
more specific ones from the load functions that should be enough. (I'm 
always unsure how to correctly use error and errp so some more expert 
opinion could be useful but otherwise this series does not seem to 
simplify things much.)

If you don't want to convert all these other machines I'm also OK with 
leaving these passing NULL to load_image_targphys for now and keep current 
error handling which can then be converted later so alternatively you can 
drop this patch if you can't finish it before the freeze.

Regards,
BALATON Zoltan

