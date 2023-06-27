Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F049773FF9B
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 17:26:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEAZs-0007mN-C4; Tue, 27 Jun 2023 11:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qEAZg-0007lR-LV; Tue, 27 Jun 2023 11:25:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qEAZe-0000Je-2o; Tue, 27 Jun 2023 11:25:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 463AA1F8B6;
 Tue, 27 Jun 2023 15:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1687879544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJyJwHDcnAGSyIkTPF/s+U+G4ty4b5iosZthWmu9Jpg=;
 b=UiDO6uqasU1OA0+Z5d5WhfiuGfMxUlBXC42wDNqXw6YkPsqE0b1Uxjc7wyl3PH4aukLUmS
 ytjHG0WNPjvGO3CdgWt0ZOHZX7mOFzK0naH/QP6bkeCOWi7oup89ioh9qPV/sJb7E1vWXD
 e5/gcTXFqExdgOeCRem4N+kU6Nk9fFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1687879544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJyJwHDcnAGSyIkTPF/s+U+G4ty4b5iosZthWmu9Jpg=;
 b=X2ZxhXKd9B4PYYaESpACNw7YipjieC8q2Eu+itByWhDmIePqnMdWjskPdqLi0YaP0t/7Jv
 Se2izeUuYH07GkCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA27113276;
 Tue, 27 Jun 2023 15:25:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id j7zuJHf/mmSAKwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 27 Jun 2023 15:25:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, Daniel
 Henrique Barboza <danielhb413@gmail.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] target/ppc: Implement attn instruction on BookS
 64-bit processors
In-Reply-To: <20230627134644.260663-5-npiggin@gmail.com>
References: <20230627134644.260663-1-npiggin@gmail.com>
 <20230627134644.260663-5-npiggin@gmail.com>
Date: Tue, 27 Jun 2023 12:25:41 -0300
Message-ID: <87352dexl6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Nicholas Piggin <npiggin@gmail.com> writes:

> attn is an implementation-specific instruction that on POWER (and G5/
> 970) can be enabled with a HID bit (disabled =3D illegal), and executing
> it causes the host processor to stop and the service processor to be
> notified. Generally used for debugging.
>
> Implement attn and make it checkstop the system, which should be good
> enough for QEMU debugging.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Since v1:
> - New patch that also uses checkstop function. Works with skiboot.
>
>  target/ppc/cpu.h         |  2 ++
>  target/ppc/excp_helper.c | 28 ++++++++++++++++++++++++++++
>  target/ppc/helper.h      |  2 ++
>  target/ppc/translate.c   |  7 +++++++
>  4 files changed, 39 insertions(+)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 94497aa115..f6e93dec5f 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2116,6 +2116,8 @@ void ppc_compat_add_property(Object *obj, const cha=
r *name,
>  #define HID0_NAP            (1 << 22)           /* pre-2.06 */
>  #define HID0_HILE           PPC_BIT(19) /* POWER8 */
>  #define HID0_POWER9_HILE    PPC_BIT(4)
> +#define HID0_ENABLE_ATTN    PPC_BIT(31) /* POWER8 */
> +#define HID0_POWER9_ENABLE_ATTN PPC_BIT(3)
>=20=20
>  /***********************************************************************=
******/
>  /* PowerPC Instructions types definitions                               =
     */
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 28d8a9b212..f46fdd2ee6 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -208,6 +208,34 @@ static void powerpc_checkstop(CPUPPCState *env, cons=
t char *reason)
>  }
>=20=20
>  #if defined(TARGET_PPC64)
> +void helper_attn(CPUPPCState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +    target_ulong hid0_attn =3D 0;
> +
> +    switch (env->excp_model) {
> +    case POWERPC_EXCP_970:
> +    case POWERPC_EXCP_POWER7:
> +    case POWERPC_EXCP_POWER8:
> +        hid0_attn =3D HID0_ENABLE_ATTN;
> +        break;
> +    case POWERPC_EXCP_POWER9:
> +    case POWERPC_EXCP_POWER10:
> +        hid0_attn =3D HID0_POWER9_ENABLE_ATTN;
> +        break;
> +    default:
> +        break;
> +    }

There's some precedent for checking HID bits using a cpu class
function. See pcc->check_pow, check_pow_hid0() and
check_pow_hid0_74xx(). I find it a bit nicer because the class carries
all the data so it's easier to move code around.

> +
> +    if (env->spr[SPR_HID0] & hid0_attn) {
> +        powerpc_checkstop(env, "host executed attn");
> +        cpu_loop_exit_noexc(cs);
> +    } else {
> +        raise_exception_err(env, POWERPC_EXCP_HV_EMU,
> +                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVA=
L);
> +    }
> +}
> +
>  static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
>                                  target_ulong *msr)
>  {
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index fda40b8a60..50bb105c08 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -812,3 +812,5 @@ DEF_HELPER_4(DSCLIQ, void, env, fprp, fprp, i32)
>=20=20
>  DEF_HELPER_1(tbegin, void, env)
>  DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
> +
> +DEF_HELPER_1(attn, void, env)
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 372ee600b2..4e9e606d77 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6382,6 +6382,12 @@ static void gen_dform3D(DisasContext *ctx)
>  }
>=20=20
>  #if defined(TARGET_PPC64)
> +/* attn */
> +static void gen_attn(DisasContext *ctx)
> +{
> +    gen_helper_attn(cpu_env);

In another incarnation of this patch, C=C3=A9dric had a check for the
privilege level and linux-user:

+static void gen_attn(DisasContext *ctx)
+{
+ #if defined(CONFIG_USER_ONLY)
+    GEN_PRIV;
+#else
+    CHK_SV;
+
+    gen_helper_attn(cpu_env, cpu_gpr[3]);
+    ctx->base.is_jmp =3D DISAS_NORETURN;
+#endif
+}

> +}
> +
>  /* brd */
>  static void gen_brd(DisasContext *ctx)
>  {
> @@ -6413,6 +6419,7 @@ static void gen_brh(DisasContext *ctx)
>=20=20
>  static opcode_t opcodes[] =3D {
>  #if defined(TARGET_PPC64)
> +GEN_HANDLER_E(attn, 0x00, 0x00, 0x08, 0xFFFFFDFF, PPC_NONE,
>  PPC2_ISA207S),

Aren't you missing the 970 with this? Maybe worth a insns_flag2 flag
just for the attn?

>  GEN_HANDLER_E(brd, 0x1F, 0x1B, 0x05, 0x0000F801, PPC_NONE, PPC2_ISA310),
>  GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA310),
>  GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, PPC2_ISA310),

