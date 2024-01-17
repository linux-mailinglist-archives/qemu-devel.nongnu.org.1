Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 445948309A5
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:23:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7ko-0000t9-Nj; Wed, 17 Jan 2024 10:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=gIDE=I3=kaod.org=clg@ozlabs.org>)
 id 1rQ7kf-0000sh-8R; Wed, 17 Jan 2024 10:22:49 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=gIDE=I3=kaod.org=clg@ozlabs.org>)
 id 1rQ7kc-0007TI-Aw; Wed, 17 Jan 2024 10:22:48 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TFV4751xNz4xVL;
 Thu, 18 Jan 2024 02:22:31 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TFV442FNMz4wdD;
 Thu, 18 Jan 2024 02:22:28 +1100 (AEDT)
Message-ID: <01265ba4-3e2b-435b-8031-e16125511af7@kaod.org>
Date: Wed, 17 Jan 2024 16:22:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/ppc/cpu-models: Rename power5+ and power7+
 for new QOM naming rules
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20240117141054.73841-1-thuth@redhat.com>
 <20240117141054.73841-2-thuth@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240117141054.73841-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=gIDE=I3=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/17/24 15:10, Thomas Huth wrote:
> The character "+" is now forbidden in QOM device names (see commit
> b447378e1217 - "Limit type names to alphanumerical and some few special
> characters"). For the "power5+" and "power7+" CPU names, there is
> currently a hack in type_name_is_valid() to still allow them for
> compatibility reasons. However, there is a much nicer solution for this:
> Simply use aliases! This way we can still support the old names without
> the need for the ugly hack in type_name_is_valid().
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/ppc/spapr_cpu_core.c |  4 ++--
>   qom/object.c            |  4 ----
>   target/ppc/cpu-models.c | 10 ++++++----
>   3 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 5aa1ed474a..0c0fb3f1b0 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -389,9 +389,9 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
>       DEFINE_SPAPR_CPU_CORE_TYPE("970_v2.2"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.0"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.1"),
> -    DEFINE_SPAPR_CPU_CORE_TYPE("power5+_v2.1"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power5p_v2.1"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("power7_v2.3"),
> -    DEFINE_SPAPR_CPU_CORE_TYPE("power7+_v2.1"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power7p_v2.1"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("power8_v2.0"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
> diff --git a/qom/object.c b/qom/object.c
> index 654e1afaf2..2c4c64d2b6 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -160,10 +160,6 @@ static bool type_name_is_valid(const char *name)
>   
>       /* Allow some legacy names with '+' in it for compatibility reasons */
>       if (name[plen] == '+') {
> -        if (plen == 6 && g_str_has_prefix(name, "power")) {
> -            /* Allow "power5+" and "power7+" CPU names*/
> -            return true;
> -        }
>           if (plen >= 17 && g_str_has_prefix(name, "Sun-UltraSparc-I")) {
>               /* Allow "Sun-UltraSparc-IV+" and "Sun-UltraSparc-IIIi+" */
>               return true;
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index 7dbb47de64..36e465b390 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -716,11 +716,11 @@
>                   "PowerPC 970MP v1.0")
>       POWERPC_DEF("970mp_v1.1",    CPU_POWERPC_970MP_v11,              970,
>                   "PowerPC 970MP v1.1")
> -    POWERPC_DEF("power5+_v2.1",  CPU_POWERPC_POWER5P_v21,            POWER5P,
> +    POWERPC_DEF("power5p_v2.1",  CPU_POWERPC_POWER5P_v21,            POWER5P,
>                   "POWER5+ v2.1")
>       POWERPC_DEF("power7_v2.3",   CPU_POWERPC_POWER7_v23,             POWER7,
>                   "POWER7 v2.3")
> -    POWERPC_DEF("power7+_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
> +    POWERPC_DEF("power7p_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
>                   "POWER7+ v2.1")
>       POWERPC_DEF("power8e_v2.1",  CPU_POWERPC_POWER8E_v21,            POWER8,
>                   "POWER8E v2.1")
> @@ -902,10 +902,12 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
>       { "970", "970_v2.2" },
>       { "970fx", "970fx_v3.1" },
>       { "970mp", "970mp_v1.1" },
> -    { "power5+", "power5+_v2.1" },
> +    { "power5+", "power5p_v2.1" },
> +    { "power5+_v2.1", "power5p_v2.1" },
>       { "power5gs", "power5+_v2.1" },
>       { "power7", "power7_v2.3" },
> -    { "power7+", "power7+_v2.1" },
> +    { "power7+", "power7p_v2.1" },
> +    { "power7+_v2.1", "power7p_v2.1" },
>       { "power8e", "power8e_v2.1" },
>       { "power8", "power8_v2.0" },
>       { "power8nvl", "power8nvl_v1.0" },


