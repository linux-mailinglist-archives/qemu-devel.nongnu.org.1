Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 497D978D6DB
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:14:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMtK-0003S0-L3; Wed, 30 Aug 2023 11:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMtI-0003Jo-65
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:13:56 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMtF-0005mX-DW
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:13:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-401d6f6b2e0so6483305e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693408432; x=1694013232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uw+3nn4Kw4FUgN02a2vMZLgzIhXtcU8zFH4vudGCslk=;
 b=SiSI5TcEHq0djXHnwUbzWlR0aRr5SsrlDtwosqD603AVE93NjVTkj/LkgvWdPNYGUM
 kNR1ETYcE0MhaGmB9XdxaJWStoKq91B87bbwMelmZjC+Q1iAZ8Bn899UHD+J399LtVRB
 UW9aqsO+Fqjik2pQT6smkDUKe1etb93Gyk4LJMjpPLTfWYuGkEnwch5euYPgLSlNwShY
 V+sqklpSB7glwaUKGoYUis3HBawTo6Krx3S3PLko5YM/supuynYTzXoTOhx81O9DFcAP
 XfRTwjO2JVFkVli507j/jdecek8/TT7H2loY5JNIH9zgOEMlcl6Z//9oaMlGFM8MQ+DI
 N/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693408432; x=1694013232;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Uw+3nn4Kw4FUgN02a2vMZLgzIhXtcU8zFH4vudGCslk=;
 b=EFOLb/HCXmGr4RQeYvqLgEukOOdF0VHPdI4pkH6jKu1hz7oUH9gRt6LlzekOSzghtw
 rH6IM80g3XJRXk0Bi9itObcXlIa08iAPkkzkuQtAFDbdombcEY2V4951KvmVuEEMmTr7
 Y5rpqMLaDsycEPtke5+nDY8VAOwvBKqnwxuwjkgmLcbKFlFG1odVZTvZuk08eH8tWIFf
 lI9kI1VcYt4KbskelNoqQpnJIwoL93bXMWdKiGzcHTDJd/S38Znw5U8yPVGPairj4wcT
 f7ARXtQgW4yzXbtajmmhc2lxKnCketgDKdndP0Uc0H26fdQdXkiW/yUwJrUE5MzYExw8
 N7yA==
X-Gm-Message-State: AOJu0YwBM/ObJ8Ph6p2dWtHTnJpcoA4PxWgqm+ox5gcsAITf0c/r6gDl
 aQK+DTq9wdSQUSYUn8X1fDzvvQ==
X-Google-Smtp-Source: AGHT+IFzL0xOH0XdYd5lOt8ghN3HnbesIitAzyX/JNmTo5lp8izhNgI6v7V2iLgG0Jx+xS1I3l11mA==
X-Received: by 2002:a05:6000:187:b0:316:f4b9:a952 with SMTP id
 p7-20020a056000018700b00316f4b9a952mr4713365wrx.31.1693408431589; 
 Wed, 30 Aug 2023 08:13:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a5d6108000000b0031434c08bb7sm16807187wrt.105.2023.08.30.08.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 08:13:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A601C1FFBB;
 Wed, 30 Aug 2023 16:13:50 +0100 (BST)
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
 <20230818033648.8326-25-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Alexandre Iooss
 <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, Richard
 Henderson <richard.henderson@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH RESEND v5 24/26] contrib/plugins: Allow to log registers
Date: Wed, 30 Aug 2023 16:08:11 +0100
In-reply-to: <20230818033648.8326-25-akihiko.odaki@daynix.com>
Message-ID: <87a5u8r2a9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> This demonstrates how a register can be read from a plugin.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  docs/devel/tcg-plugins.rst |  10 ++-
>  contrib/plugins/execlog.c  | 140 ++++++++++++++++++++++++++++---------
>  2 files changed, 117 insertions(+), 33 deletions(-)
>
> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
> index 81dcd43a61..c9f8b27590 100644
> --- a/docs/devel/tcg-plugins.rst
> +++ b/docs/devel/tcg-plugins.rst
> @@ -497,6 +497,15 @@ arguments if required::
>    $ qemu-system-arm $(QEMU_ARGS) \
>      -plugin ./contrib/plugins/libexeclog.so,ifilter=3Dst1w,afilter=3D0x4=
0001808 -d plugin
>=20=20
> +This plugin can also dump a specified register. The specification of reg=
ister
> +follows `GDB standard target features <https://sourceware.org/gdb/online=
docs/gdb/Standard-Target-Features.html>`__.
> +
> +Specify the name of the feature that contains the register and the name =
of the
> +register with ``rfile`` and ``reg`` options, respectively::
> +
> +  $ qemu-system-arm $(QEMU_ARGS) \
> +    -plugin ./contrib/plugins/libexeclog.so,rfile=3Dorg.gnu.gdb.arm.core=
,reg=3Dsp -d plugin
> +
>  - contrib/plugins/cache.c
>=20=20
>  Cache modelling plugin that measures the performance of a given L1 cache
> @@ -583,4 +592,3 @@ The following API is generated from the inline docume=
ntation in
>  include the full kernel-doc annotations.
>=20=20
>  .. kernel-doc:: include/qemu/qemu-plugin.h
> -
> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
> index 82dc2f584e..aa05840fd0 100644
> --- a/contrib/plugins/execlog.c
> +++ b/contrib/plugins/execlog.c
> @@ -15,27 +15,43 @@
>=20=20
>  #include <qemu-plugin.h>
>=20=20
> +typedef struct CPU {
> +    /* Store last executed instruction on each vCPU as a GString */
> +    GString *last_exec;
> +    GByteArray *reg_history[2];
> +
> +    int reg;
> +} CPU;
> +
>  QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
>=20=20
<snip>
>=20=20
>      /* Store new instruction in cache */
>      /* vcpu_mem will add memory access information to last_exec */
> -    g_string_printf(s, "%u, ", cpu_index);
> -    g_string_append(s, (char *)udata);
> +    g_string_printf(cpus[cpu_index].last_exec, "%u, ", cpu_index);
> +    g_string_append(cpus[cpu_index].last_exec, (char *)udata);
> +
> +    g_rw_lock_reader_unlock(&expand_array_lock);
>  }
>=20=20
>  /**
> @@ -167,8 +197,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struc=
t qemu_plugin_tb *tb)
>                                               QEMU_PLUGIN_MEM_RW, NULL);
>=20=20
>              /* Register callback on instruction */
> -            qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
> -                                                   QEMU_PLUGIN_CB_NO_REG=
S, output);
> +            qemu_plugin_register_vcpu_insn_exec_cb(
> +                insn, vcpu_insn_exec,
> +                rfile_name ? QEMU_PLUGIN_CB_R_REGS : QEMU_PLUGIN_CB_NO_R=
EGS,
> +                output);
>=20=20
>              /* reset skip */
>              skip =3D (imatches || amatches);
> @@ -177,17 +209,53 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, stru=
ct qemu_plugin_tb *tb)
>      }
>  }
>=20=20
> +static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
> +{
> +    int reg =3D 0;
> +    bool found =3D false;
> +
> +    expand_cpu(vcpu_index);
> +
> +    if (rfile_name) {
> +        int i;
> +        int j;
> +        int n;
> +
> +        qemu_plugin_register_file_t *rfiles =3D
> +            qemu_plugin_get_register_files(vcpu_index, &n);
> +
> +        for (i =3D 0; i < n; i++) {
> +            if (g_strcmp0(rfiles[i].name, rfile_name) =3D=3D 0) {
> +                for (j =3D 0; j < rfiles[i].num_regs; j++) {
> +                    if (g_strcmp0(rfiles[i].regs[j], reg_name) =3D=3D 0)=
 {
> +                        reg +=3D j;
> +                        found =3D true;
> +                        break;
> +                    }
> +                }
> +                break;
> +            }
> +
> +            reg +=3D rfiles[i].num_regs;
> +        }
> +
> +        g_free(rfiles);
> +    }

This makes me question the value of exposing the register file directly
to the plugin. I would much rather have a lookup utility function with
an optional tag. Something like:

  plugin_reg_t qemu_plugin_find_register(const char *name, const char *tag);

And make tag optional. I think in the general case "name" should be enough.

> +
> +    g_rw_lock_writer_lock(&expand_array_lock);
> +    cpus[vcpu_index].reg =3D found ? reg : -1;
> +    g_rw_lock_writer_unlock(&expand_array_lock);
> +}
> +
>  /**
>   * On plugin exit, print last instruction in cache
>   */
>  static void plugin_exit(qemu_plugin_id_t id, void *p)
>  {
>      guint i;
> -    GString *s;
> -    for (i =3D 0; i < last_exec->len; i++) {
> -        s =3D g_ptr_array_index(last_exec, i);
> -        if (s->str) {
> -            qemu_plugin_outs(s->str);
> +    for (i =3D 0; i < num_cpus; i++) {
> +        if (cpus[i].last_exec->str) {
> +            qemu_plugin_outs(cpus[i].last_exec->str);
>              qemu_plugin_outs("\n");
>          }
>      }
> @@ -224,9 +292,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugi=
n_id_t id,
>       * we don't know the size before emulation.
>       */
>      if (info->system_emulation) {
> -        last_exec =3D g_ptr_array_sized_new(info->system.max_vcpus);
> -    } else {
> -        last_exec =3D g_ptr_array_new();
> +        cpus =3D g_new(CPU, info->system.max_vcpus);
>      }
>=20=20
>      for (int i =3D 0; i < argc; i++) {
> @@ -236,13 +302,23 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plu=
gin_id_t id,
>              parse_insn_match(tokens[1]);
>          } else if (g_strcmp0(tokens[0], "afilter") =3D=3D 0) {
>              parse_vaddr_match(tokens[1]);
> +        } else if (g_strcmp0(tokens[0], "rfile") =3D=3D 0) {
> +            rfile_name =3D g_strdup(tokens[1]);
> +        } else if (g_strcmp0(tokens[0], "reg") =3D=3D 0) {
> +            reg_name =3D g_strdup(tokens[1]);

And then instead of having the rfile/reg distinction support a command
line like:

  qemu-aarch64 -plugin contrib/plugins/libexeclog.so,reg=3Dsp,reg=3Dx1,reg=
=3Dsve:p1

so if the user specifies a reg of the form TAG:REG we can pass that as
the option tag string. It also avoids exposing all the details of gdb to
plugins while still allowing the utility function to search by rname
internally (even if only a substring match?),


>          } else {
>              fprintf(stderr, "option parsing failed: %s\n", opt);
>              return -1;
>          }
>      }
>=20=20
> +    if ((!rfile_name) !=3D (!reg_name)) {
> +        fputs("file and reg need to be set at the same time\n", stderr);
> +        return -1;
> +    }
> +
>      /* Register translation block and exit callbacks */
> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>      qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>      qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

