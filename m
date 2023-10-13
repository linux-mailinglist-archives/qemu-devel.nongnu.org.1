Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B315B7C8B7E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 18:37:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLAB-0006ez-Qp; Fri, 13 Oct 2023 12:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrL9w-0006eS-Tn
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:37:15 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrL9t-0006WX-DF
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:37:08 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so2130305f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697215023; x=1697819823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oI97ILR25LraaJqLuq2ABYA+m1UoESrvvhRO+ySIypw=;
 b=a20R73yEdpiDHbUUENad0jT0nKMcy/yS7a6flFEO2r8iLY7MfccxVwigulyYmkRJgo
 +ohZqMjSPHQ7XcWinHtrGWYUq/9B1El2Mhy9V/XuKsvuKNONYy3JBe018vnPLdmRpXOU
 +DPVV1cRi0Pk5UxC6CJDpHCnxtLhbF/TcfpwLd7RPWYiuXjov/3t5U3/uC6c8BT9ld3w
 kwSd4U8M6UfA8CCRmbk4ZGgXyK5vwB8ZOWm4EdMsd/kQuxU0T9GkawJWMw+3oAB5vxh5
 74xDNme5+21xUGvfaJNp6CH2LqrUorv3/6SvvFc41MdfSGGjGvPxW648X4HNhn0lGHX+
 G8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697215023; x=1697819823;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oI97ILR25LraaJqLuq2ABYA+m1UoESrvvhRO+ySIypw=;
 b=rI+Bla7s6FbQi7htrRnclbwNCpSgsDGYbVHtAz9gJF4GZqns/pwQvNDvCBxvq2/DBW
 SzyA21o1NOnhHFEGxUAiy6iAX5wY5qAHGpxwCHPdFjU6uFOQmgFkFbsTEfRDisClCana
 rMqimPqcjNVt+/9Yb6drcgF4U1gCwNc2OeCUFj6T2wbKqRpq7aAyWi5VOr6003awaWKN
 71NIy1wXoshVCdLa2bcZ8oIiionVYCBfIrYLULXiCEBjsylrItrHBw/67ih3YX4ytisl
 HWu2CSfeH56ft6hd0QUCr2zyV00DP+Sj9uLjh60g1DgKp9QgMSEf7XtHmE+KH0BmCJe/
 nQWA==
X-Gm-Message-State: AOJu0YxBmI0U9Me0dOaqo7JNmi/zMBcK+jLpQWVvNaO8769uZsYlux7M
 WT1fQTI75OESa3LqgHWIOrmHT3JcWMe/CjFdf2w=
X-Google-Smtp-Source: AGHT+IFShRqr+loxWyCKOsQT6i6pcMfqQ9U8uH/xb564hDaIWZR0wYusVfFWPjPmIr2MbjdiT65cfg==
X-Received: by 2002:a05:6000:1001:b0:32d:81fe:7104 with SMTP id
 a1-20020a056000100100b0032d81fe7104mr7723552wrx.63.1697215023343; 
 Fri, 13 Oct 2023 09:37:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 dj16-20020a0560000b1000b003198a9d758dsm4146008wrb.78.2023.10.13.09.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:37:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7A5951FFBB;
 Fri, 13 Oct 2023 17:37:02 +0100 (BST)
References: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
 <20231006090610.26171-26-nicolas.eder@lauterbach.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Christian.Boenig@lauterbach.com
Subject: Re: [PATCH v2 25/29] Doxygen documentation added
Date: Fri, 13 Oct 2023 17:34:56 +0100
In-reply-to: <20231006090610.26171-26-nicolas.eder@lauterbach.com>
Message-ID: <878r86mqc1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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


Nicolas Eder <nicolas.eder@lauterbach.com> writes:

> From: neder <nicolas.eder@lauterbach.com>
>
> ---
>  include/exec/mcdstub.h       |   7 -
>  include/mcdstub/syscalls.h   |   2 +-
>  mcdstub/mcd_shared_defines.h |   1 +
>  mcdstub/mcdstub.c            |  61 ++--
>  mcdstub/mcdstub.h            | 579 ++++++++++++++++++++++++++++++++++-
>  mcdstub/mcdstub_common.h     |  18 ++
>  target/arm/mcdstub.c         |   6 -
>  target/arm/mcdstub.h         | 105 +++++++
>  8 files changed, 709 insertions(+), 70 deletions(-)
>
> diff --git a/include/exec/mcdstub.h b/include/exec/mcdstub.h
> index 84f7c811cb..9b7c31a951 100644
> --- a/include/exec/mcdstub.h
> +++ b/include/exec/mcdstub.h
> @@ -3,13 +3,6 @@
>=20=20
>  #define DEFAULT_MCDSTUB_PORT "1235"
>=20=20
> -/* breakpoint defines */
> -#define MCD_BREAKPOINT_SW        0
> -#define MCD_BREAKPOINT_HW        1
> -#define MCD_WATCHPOINT_WRITE     2
> -#define MCD_WATCHPOINT_READ      3
> -#define MCD_WATCHPOINT_ACCESS    4
> -
>  /**
>   * mcd_tcp_server_start: start the tcp server to connect via mcd
>   * @device: connection spec for mcd
> diff --git a/include/mcdstub/syscalls.h b/include/mcdstub/syscalls.h
> index 5547d6d29e..52a26be3a9 100644
> --- a/include/mcdstub/syscalls.h
> +++ b/include/mcdstub/syscalls.h
> @@ -3,4 +3,4 @@
>=20=20
>  typedef void (*gdb_syscall_complete_cb)(CPUState *cpu, uint64_t ret, int=
 err);
>=20=20
> -#endif /* _SYSCALLS_H_ */
> +#endif /* _MCD_SYSCALLS_H_ */
> diff --git a/mcdstub/mcd_shared_defines.h b/mcdstub/mcd_shared_defines.h
> index 5fbd732252..110d36d975 100644
> --- a/mcdstub/mcd_shared_defines.h
> +++ b/mcdstub/mcd_shared_defines.h
> @@ -38,6 +38,7 @@
>  /* tcp query arguments */
>  #define QUERY_FIRST "f"
>  #define QUERY_CONSEQUTIVE "c"
> +#define QUERY_END_INDEX "!"
>=20=20
>  #define QUERY_ARG_SYSTEM "system"
>  #define QUERY_ARG_CORES "cores"
> diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
> index 7613ed2c4a..a468a7d7b8 100644
> --- a/mcdstub/mcdstub.c
> +++ b/mcdstub/mcdstub.c
> @@ -218,12 +218,6 @@ int find_cpu_clusters(Object *child, void *opaque)
>          s->processes =3D g_renew(MCDProcess, s->processes, ++s->process_=
num);
>=20=20
>          process =3D &s->processes[s->process_num - 1];
> -
> -        /*
> -         * GDB process IDs -1 and 0 are reserved. To avoid subtle errors=
 at
> -         * runtime, we enforce here that the machine does not use a clus=
ter ID
> -         * that would lead to PID 0.
> -         */
>          assert(cluster->cluster_id !=3D UINT32_MAX);
>          process->pid =3D cluster->cluster_id + 1;
>          process->attached =3D false;
> @@ -925,7 +919,7 @@ void mcd_vm_state_change(void *opaque, bool running, =
RunState state)
>=20=20
>  int mcd_put_packet(const char *buf)
>  {
> -    return mcd_put_packet_binary(buf, strlen(buf), false);
> +    return mcd_put_packet_binary(buf, strlen(buf));
>  }
>=20=20
>  void mcd_put_strbuf(void)
> @@ -933,7 +927,7 @@ void mcd_put_strbuf(void)
>      mcd_put_packet(mcdserver_state.str_buf->str);
>  }
>=20=20
> -int mcd_put_packet_binary(const char *buf, int len, bool dump)
> +int mcd_put_packet_binary(const char *buf, int len)
>  {
>      for (;;) {
>          g_byte_array_set_size(mcdserver_state.last_packet, 0);
> @@ -999,12 +993,12 @@ MCDProcess *mcd_get_process(uint32_t pid)
>      return NULL;
>  }
>=20=20
> -CPUState *mcd_get_cpu(uint32_t i_cpu_index)
> +CPUState *mcd_get_cpu(uint32_t cpu_index)
>  {
>      CPUState *cpu =3D first_cpu;
>=20=20
>      while (cpu) {
> -        if (cpu->cpu_index =3D=3D i_cpu_index) {
> +        if (cpu->cpu_index =3D=3D cpu_index) {
>              return cpu;
>          }
>          cpu =3D mcd_next_attached_cpu(cpu);
> @@ -1344,15 +1338,13 @@ void handle_open_core(GArray *params, void *user_=
ctx)
>=20=20
>  void handle_query_reset_f(GArray *params, void *user_ctx)
>  {
> -    /* TODO: vull reset over the qemu monitor */
> -
>      /* 1. check length */
>      int nb_resets =3D mcdserver_state.resets->len;
>      if (nb_resets =3D=3D 1) {
>          /* indicates this is the last packet */
> -        g_string_printf(mcdserver_state.str_buf, "0!");
> +        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
>      } else {
> -        g_string_printf(mcdserver_state.str_buf, "1!");
> +        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
>      }
>      /* 2. send data */
>      mcd_reset_st reset =3D g_array_index(mcdserver_state.resets, mcd_res=
et_st, 0);
> @@ -1370,7 +1362,7 @@ void handle_query_reset_c(GArray *params, void *use=
r_ctx)
>      int nb_groups =3D mcdserver_state.resets->len;
>      if (query_index + 1 =3D=3D nb_groups) {
>          /* indicates this is the last packet */
> -        g_string_printf(mcdserver_state.str_buf, "0!");
> +        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
>      } else {
>          g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
>      }
> @@ -1487,9 +1479,9 @@ void handle_query_mem_spaces_f(GArray *params, void=
 *user_ctx)
>      int nb_groups =3D memspaces->len;
>      if (nb_groups =3D=3D 1) {
>          /* indicates this is the last packet */
> -        g_string_printf(mcdserver_state.str_buf, "0!");
> +        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
>      } else {
> -        g_string_printf(mcdserver_state.str_buf, "1!");
> +        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
>      }
>=20=20
>      /* 3. send data */
> @@ -1522,7 +1514,7 @@ void handle_query_mem_spaces_c(GArray *params, void=
 *user_ctx)
>      int nb_groups =3D memspaces->len;
>      if (query_index + 1 =3D=3D nb_groups) {
>          /* indicates this is the last packet */
> -        g_string_printf(mcdserver_state.str_buf, "0!");
> +        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
>      } else {
>          g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
>      }
> @@ -1555,9 +1547,9 @@ void handle_query_reg_groups_f(GArray *params, void=
 *user_ctx)
>      int nb_groups =3D reggroups->len;
>      if (nb_groups =3D=3D 1) {
>          /* indicates this is the last packet */
> -        g_string_printf(mcdserver_state.str_buf, "0!");
> +        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
>      } else {
> -        g_string_printf(mcdserver_state.str_buf, "1!");
> +        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
>      }
>      /* 3. send data */
>      mcd_reg_group_st group =3D g_array_index(reggroups, mcd_reg_group_st=
, 0);
> @@ -1580,7 +1572,7 @@ void handle_query_reg_groups_c(GArray *params, void=
 *user_ctx)
>      int nb_groups =3D reggroups->len;
>      if (query_index + 1 =3D=3D nb_groups) {
>          /* indicates this is the last packet */
> -        g_string_printf(mcdserver_state.str_buf, "0!");
> +        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
>      } else {
>          g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
>      }
> @@ -1604,9 +1596,9 @@ void handle_query_regs_f(GArray *params, void *user=
_ctx)
>      int nb_regs =3D registers->len;
>      if (nb_regs =3D=3D 1) {
>          /* indicates this is the last packet */
> -        g_string_printf(mcdserver_state.str_buf, "0!");
> +        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
>      } else {
> -        g_string_printf(mcdserver_state.str_buf, "1!");
> +        g_string_printf(mcdserver_state.str_buf, "1%s", QUERY_END_INDEX);
>      }
>      /* 3. send data */
>      mcd_reg_st my_register =3D g_array_index(registers, mcd_reg_st, 0);
> @@ -1637,7 +1629,7 @@ void handle_query_regs_c(GArray *params, void *user=
_ctx)
>      int nb_regs =3D registers->len;
>      if (query_index + 1 =3D=3D nb_regs) {
>          /* indicates this is the last packet */
> -        g_string_printf(mcdserver_state.str_buf, "0!");
> +        g_string_printf(mcdserver_state.str_buf, "0%s", QUERY_END_INDEX);
>      } else {
>          g_string_printf(mcdserver_state.str_buf, "%u!", query_index + 1);
>      }
> @@ -1672,19 +1664,8 @@ void handle_query_state(GArray *params, void *user=
_ctx)
>       * get state info
>       */
>      mcd_cpu_state_st state_info =3D mcdserver_state.cpu_state;
> -    mcd_core_event_et event =3D MCD_CORE_EVENT_NONE;
> -    if (state_info.memory_changed) {
> -        event =3D event | MCD_CORE_EVENT_MEMORY_CHANGE;
> -        state_info.memory_changed =3D false;
> -    }
> -    if (state_info.registers_changed) {
> -        event =3D event | MCD_CORE_EVENT_REGISTER_CHANGE;
> -        state_info.registers_changed =3D false;
> -    }
> -    if (state_info.target_was_stopped) {
> -        event =3D event | MCD_CORE_EVENT_STOPPED;
> -        state_info.target_was_stopped =3D false;
> -    }
> +    /* TODO: add event information */
> +    uint32_t event =3D 0;
>      /* send data */
>      g_string_printf(mcdserver_state.str_buf,
>          "%s=3D%s.%s=3D%u.%s=3D%u.%s=3D%u.%s=3D%lu.%s=3D%s.%s=3D%s.",
> @@ -1863,7 +1844,7 @@ void handle_write_memory(GArray *params, void *user=
_ctx)
>          mcd_put_packet(TCP_EXECUTION_ERROR);
>          return;
>      }
> -    /* read memory */
> +    /* write memory */
>      mcd_hextomem(mcdserver_state.mem_buf, mcdserver_state.str_buf->str, =
len);
>      if (mcd_write_memory(cpu, mem_address,
>          mcdserver_state.mem_buf->data, len) !=3D 0) {
> @@ -1879,7 +1860,7 @@ int mcd_breakpoint_insert(CPUState *cpu, int type, =
vaddr addr)
>      int bp_type =3D 0;
>      CPUClass *cc =3D CPU_GET_CLASS(cpu);
>      if (cc->gdb_stop_before_watchpoint) {
> -        //bp_type |=3D BP_STOP_BEFORE_ACCESS;
> +        /* bp_type |=3D BP_STOP_BEFORE_ACCESS; */
>      }
>      int return_value =3D 0;
>      switch (type) {
> @@ -1909,7 +1890,7 @@ int mcd_breakpoint_remove(CPUState *cpu, int type, =
vaddr addr)
>      int bp_type =3D 0;
>      CPUClass *cc =3D CPU_GET_CLASS(cpu);
>      if (cc->gdb_stop_before_watchpoint) {
> -        //bp_type |=3D BP_STOP_BEFORE_ACCESS;
> +        /* bp_type |=3D BP_STOP_BEFORE_ACCESS; */
>      }
>      int return_value =3D 0;
>      switch (type) {
> diff --git a/mcdstub/mcdstub.h b/mcdstub/mcdstub.h
> index d3f15da180..5412b59423 100644
> --- a/mcdstub/mcdstub.h
> +++ b/mcdstub/mcdstub.h
> @@ -12,20 +12,6 @@
>  #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
>  #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
>=20=20
> -typedef uint32_t mcd_core_event_et;
> -/* TODO: replace mcd defines with custom layer */
> -enum {
> -    MCD_CORE_EVENT_NONE            =3D 0x00000000,
> -    MCD_CORE_EVENT_MEMORY_CHANGE   =3D 0x00000001,
> -    MCD_CORE_EVENT_REGISTER_CHANGE =3D 0x00000002,
> -    MCD_CORE_EVENT_TRACE_CHANGE    =3D 0x00000004,
> -    MCD_CORE_EVENT_TRIGGER_CHANGE  =3D 0x00000008,
> -    MCD_CORE_EVENT_STOPPED         =3D 0x00000010,
> -    MCD_CORE_EVENT_CHL_PENDING     =3D 0x00000020,
> -    MCD_CORE_EVENT_CUSTOM_LO       =3D 0x00010000,
> -    MCD_CORE_EVENT_CUSTOM_HI       =3D 0x40000000,
> -};
> -

None of these changes have to do with adding documentation.

>  /* schema defines */
>  #define ARG_SCHEMA_QRYHANDLE 'q'
>  #define ARG_SCHEMA_STRING 's'
> @@ -187,88 +173,649 @@ static inline int tohex(int v)
>  void mcd_sigterm_handler(int signal);
>  #endif
>=20=20
> +/**
> + * \defgroup mcdstub Main mcdstub functions
> + * All architecture independent mcdstub functions.
> + */
> +
> +/**
> + * \addtogroup mcdstub
> + * @{
> + */
> +
> +/**
> + * \brief Initializes the mcdserver_state struct.
> + *
> + * This function allocates memory for the mcdserver_state struct and sets
> + * all of its members to their inital values. This includes setting the
> + * cpu_state to halted and initializing the query functions with \ref
> + * init_query_cmds_table.
> + */

We already have a documentation standard for functions and it is kdoc:

  https://www.kernel.org/doc/html/v5.0/doc-guide/kernel-doc.html

which is integrated into our documentation system. Please use that.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

