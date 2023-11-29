Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 657917FDCF8
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 17:27:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8NNa-0008Km-KF; Wed, 29 Nov 2023 11:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8NNU-0008KQ-VC
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 11:25:32 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8NNS-0000Iy-Dh
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 11:25:32 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3331bb4b116so392870f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 08:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701275126; x=1701879926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLz6zg7VfIOKEuGjZUk+SmQl3rNkAGNbC9utfGs4chM=;
 b=msQZe9PjlO/14qXd9dVli6T8f8EzS4k5IsBtsK3I8y88r1IAhhxDbSPBuR2WmIXAsS
 VYSyDVu5VQ1tUOZlnJL7wI+CtXPXXlxQWVgcDUpE6eiumtNg/qkU0DhvxEm0A7zzBi9a
 jgrUkyhHEmCwlqYwy2XyjNejplrYezL8ahLcAaFz1ZjEy0nrimzgDszCJo2DwDTqGrpN
 rD8PAl0iBJywkB+9iOmaxXTR0lXeSRVJYvbHvhsCB+c54MIPvVHgADV9TUhrs1PC2rz3
 C0001+NUMV+tLEyXCFCtyP+fhNXpkzRGV9Pcw8I8k1kmPKIGpAlxMuLL++rO3oSDGdvK
 SgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701275126; x=1701879926;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DLz6zg7VfIOKEuGjZUk+SmQl3rNkAGNbC9utfGs4chM=;
 b=U8aXAtiiTaV5rlnW9AxelaoJP6PaAfJSzYws7efkn2N1Q371eZazRv2GYmd+J2dKoV
 nxb4YjZ4g5y9EaHE2e1XPx7DBcjXlGgdlsK4anB41Qpss06/GVRjDgzXiW+yo3paSuUg
 q+eIbhU6EMsJ1JQCfVKCdXH6R2rvAtJ1WtlqObi9JsP+UCYd/i6Fc33Au03qZBfS1e0e
 fp8MQNF/VAjWScDcCTxtpSeRohKHBdRau4Jre28TBR29XE/wstjDiZTjbRepkdB3tXoI
 97qEVk7nNHxD3hFO7twXulCfZ5b+A4H9zXzmzyKFxUl78w+oumZDGUSwAFFKqnSTDaGX
 djDw==
X-Gm-Message-State: AOJu0Yy+oFPsrl++qQ9XqbupaY44ZX6iXWCKl2wWmq133b0IoL9tlAle
 Ajr3l4SvYM0IxqpGxNd5+7Es6Q==
X-Google-Smtp-Source: AGHT+IF3WybGeELEOiZKz3SNQAkZatR53xNsjpHkW20fNDAjfOAh4rspSea/UUZR5eH/ZLNAyuugRQ==
X-Received: by 2002:a05:6000:178d:b0:333:6cf:2b5 with SMTP id
 e13-20020a056000178d00b0033306cf02b5mr6964401wrg.46.1701275125766; 
 Wed, 29 Nov 2023 08:25:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 df2-20020a5d5b82000000b003317796e0e3sm18026944wrb.65.2023.11.29.08.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 08:25:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D9FD35F7AF;
 Wed, 29 Nov 2023 16:25:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: Re: [PATCH v3 05/20] mcdstub: tcp packet processing added
In-Reply-To: <20231107130323.4126-6-nicolas.eder@lauterbach.com> (Nicolas
 Eder's message of "Tue, 7 Nov 2023 14:03:08 +0100")
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
 <20231107130323.4126-6-nicolas.eder@lauterbach.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Wed, 29 Nov 2023 16:25:24 +0000
Message-ID: <87zfyw8r2j.fsf@draig.linaro.org>
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

Nicolas Eder <nicolas.eder@lauterbach.com> writes:

> ---
>  include/mcdstub/mcdstub.h | 144 ++++++++++++++++++++
>  mcdstub/mcdstub.c         | 277 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 421 insertions(+)
>
> diff --git a/include/mcdstub/mcdstub.h b/include/mcdstub/mcdstub.h
> index 36058157ae..1461d0e1cb 100644
> --- a/include/mcdstub/mcdstub.h
> +++ b/include/mcdstub/mcdstub.h
> @@ -25,6 +25,21 @@ typedef struct MCDProcess {
>      char target_xml[1024];
>  } MCDProcess;
>=20=20
> +typedef void (*MCDCmdHandler)(GArray *params, void *user_ctx);
> +typedef struct MCDCmdParseEntry {
> +    MCDCmdHandler handler;
> +    const char *cmd;
> +    char schema[CMD_SCHEMA_LENGTH];
> +} MCDCmdParseEntry;
> +
> +typedef union MCDCmdVariant {
> +    const char *data;
> +    uint32_t data_uint32_t;
> +    uint64_t data_uint64_t;
> +    uint32_t query_handle;
> +    uint32_t cpu_id;
> +} MCDCmdVariant;
> +

These need to be in an earlier patch to keep the build working.

>  #define get_param(p, i)    (&g_array_index(p, MCDCmdVariant, i))
>=20=20
>  enum RSState {
> @@ -176,6 +191,35 @@ bool mcd_supports_guest_debug(void);
>   * @state: The new (and active) VM run state.
>   */
>  void mcd_vm_state_change(void *opaque, bool running, RunState state);
> +
> +/**
> + * mcd_put_packet() - Calls :c:func:`mcd_put_packet_binary` with buf and=
 length
> + * of buf.
> + *
> + * @buf: TCP packet data.
> + */
> +int mcd_put_packet(const char *buf);
> +
> +/**
> + * mcd_put_packet_binary() - Adds footer and header to the TCP packet da=
ta in
> + * buf.
> + *
> + * Besides adding header and footer, this function also stores the compl=
ete TCP
> + * packet in the last_packet member of the mcdserver_state. Then the pac=
ket
> + * gets send with the :c:func:`mcd_put_buffer` function.
> + * @buf: TCP packet data.
> + * @len: TCP packet length.
> + */
> +int mcd_put_packet_binary(const char *buf, int len);
> +
> +/**
> + * mcd_put_buffer() - Sends the buf as TCP packet with qemu_chr_fe_write=
_all.
> + *
> + * @buf: TCP packet data.
> + * @len: TCP packet length.
> + */
> +void mcd_put_buffer(const uint8_t *buf, int len);
> +
>  /**
>   * mcd_get_cpu_process() - Returns the process of the provided CPU.
>   *
> @@ -218,6 +262,82 @@ CPUState *mcd_first_attached_cpu(void);
>   */
>  CPUState *mcd_next_attached_cpu(CPUState *cpu);
>=20=20
> +/**
> + * mcd_read_byte() - Resends the last packet if not acknowledged and ext=
racts
> + * the data from a received TCP packet.
> + *
> + * In case the last sent packet was not acknowledged from the mcdstub,
> + * this function resends it.
> + * If it was acknowledged this function parses the incoming packet
> + * byte by byte.
> + * It extracts the data in the packet and sends an
> + * acknowledging response when finished. Then :c:func:`mcd_handle_packet=
` gets
> + * called.
> + * @ch: Character of the received TCP packet, which should be parsed.
> + */
> +void mcd_read_byte(uint8_t ch);
> +
> +/**
> + * mcd_handle_packet() - Evaluates the type of received packet and choos=
es the
> + * correct handler.
> + *
> + * This function takes the first character of the line_buf to determine =
the
> + * type of packet. Then it selects the correct handler function and para=
meter
> + * schema. With this info it calls :c:func:`run_cmd_parser`.
> + * @line_buf: TCP packet data.
> + */
> +int mcd_handle_packet(const char *line_buf);
> +
> +/**
> + * mcd_put_strbuf() - Calls :c:func:`mcd_put_packet` with the str_buf of=
 the
> + * mcdserver_state.
> + */
> +void mcd_put_strbuf(void);
> +
> +/**
> + * run_cmd_parser() - Prepares the mcdserver_state before executing TCP =
packet
> + * functions.
> + *
> + * This function empties the str_buf and mem_buf of the mcdserver_state =
and
> + * then calls :c:func:`process_string_cmd`. In case this function fails,=
 an
> + * empty TCP packet is sent back the MCD Shared Library.
> + * @data: TCP packet data.
> + * @cmd: Handler function (can be an array of functions).
> + */
> +void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd);
> +
> +/**
> + * process_string_cmd() - Collects all parameters from the data and call=
s the
> + * correct handler.
> + *
> + * The parameters are extracted with the :c:func:`cmd_parse_params funct=
ion.
> + * This function selects the command in the cmds array, which fits the s=
tart of
> + * the data string. This way the correct commands is selected.
> + * @data: TCP packet data.
> + * @cmds: Array of possible commands.
> + * @num_cmds: Number of commands in the cmds array.
> + */
> +int process_string_cmd(void *user_ctx, const char *data,
> +    const MCDCmdParseEntry *cmds, int num_cmds);
> +
> +/**
> + * cmd_parse_params() - Extracts all parameters from a TCP packet.
> + *
> + * This function uses the schema parameter to determine which type of pa=
rameter
> + * to expect. It then extracts that parameter from the data and stores i=
t in
> + * the params GArray.
> + * @data: TCP packet data.
> + * @schema: List of expected parameters for the packet.
> + * @params: GArray with all extracted parameters.
> + */
> +int cmd_parse_params(const char *data, const char *schema, GArray *param=
s);
> +/**
> + * mcd_get_cpu_index() - Returns the internal CPU index plus one.
> + *
> + * @cpu: CPU of interest.
> + */
> +int mcd_get_cpu_index(CPUState *cpu);
> +

Aren't these all internal to mcdstub? We can keep the kdoc comments and
just make the functions static.=20

>  /**
>   * mcd_get_cpu() - Returns the CPU the index i_cpu_index.
>   *
> @@ -237,3 +357,27 @@ CPUState *get_first_cpu_in_process(MCDProcess *proce=
ss);
>   * @thread_id: ID of the desired CPU.
>   */
>  CPUState *find_cpu(uint32_t thread_id);
> +/* helpers */
> +
> +/**
> + * int_cmp() - Compares a and b and returns zero if they are equal.
> + *
> + * @a: Pointer to integer a.
> + * @b: Pointer to integer b.
> + */
> +int int_cmp(gconstpointer a, gconstpointer b);

This especially will clash with local definitions.=20

> +/**
> + * atouint64_t() - Converts a string into a unsigned 64 bit integer.
> + *
> + * @in: Pointer to input string.
> + */
> +uint64_t atouint64_t(const char *in);
> +

No _t prefixes for functions please.

> +/**
> + * atouint32_t() - Converts a string into a unsigned 32 bit integer.
> + *
> + * @in: Pointer to input string.
> + */
> +uint32_t atouint32_t(const char *in);
> +
> +#endif /* MCDSTUB_INTERNALS_H */
> diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
> index 4cdf2e42ed..6900dcd0ea 100644
> --- a/mcdstub/mcdstub.c
> +++ b/mcdstub/mcdstub.c
> @@ -80,7 +80,14 @@ void init_query_cmds_table(MCDCmdParseEntry *mcd_query=
_cmds_table)
>  {
>      /* initalizes a list of all query commands */
>      int cmd_number =3D 0;
> +
> +void reset_mcdserver_state(void)
> +{
> +    g_free(mcdserver_state.processes);
> +    mcdserver_state.processes =3D NULL;
> +    mcdserver_state.process_num =3D 0;
>  }
> +
>  void create_processes(MCDState *s)
>  {
>      object_child_foreach(object_get_root(), find_cpu_clusters, s);
> @@ -243,6 +250,228 @@ void mcd_chr_receive(void *opaque, const uint8_t *b=
uf, int size)
>      }
>  }
>=20=20
> +void mcd_read_byte(uint8_t ch)
> +{
> +    uint8_t reply;
> +
> +    if (mcdserver_state.last_packet->len) {
> +        if (ch =3D=3D TCP_NOT_ACKNOWLEDGED) {
> +            /* the previous packet was not akcnowledged */
> +            mcd_put_buffer(mcdserver_state.last_packet->data,
> +                mcdserver_state.last_packet->len);
> +        } else if (ch =3D=3D TCP_ACKNOWLEDGED) {
> +            /* the previous packet was acknowledged */
> +        }
> +
> +        if (ch =3D=3D TCP_ACKNOWLEDGED || ch =3D=3D TCP_COMMAND_START) {
> +            /*
> +             * either acknowledged or a new communication starts
> +             * -> discard previous packet
> +             */
> +            g_byte_array_set_size(mcdserver_state.last_packet, 0);
> +        }
> +        if (ch !=3D TCP_COMMAND_START) {
> +            /* skip to the next char */
> +            return;
> +        }
> +    }
> +
> +    switch (mcdserver_state.state) {
> +    case RS_IDLE:
> +        if (ch =3D=3D TCP_COMMAND_START) {
> +            /* start of command packet */
> +            mcdserver_state.line_buf_index =3D 0;
> +            mcdserver_state.line_sum =3D 0;
> +            mcdserver_state.state =3D RS_GETLINE;
> +        }
> +        break;
> +    case RS_GETLINE:
> +        if (ch =3D=3D TCP_COMMAND_END) {
> +            /* end of command */
> +            mcdserver_state.line_buf[mcdserver_state.line_buf_index++] =
=3D 0;
> +            mcdserver_state.state =3D RS_DATAEND;
> +        } else if (mcdserver_state.line_buf_index >=3D
> +            sizeof(mcdserver_state.line_buf) - 1) {
> +            /* the input string is too long for the linebuffer! */
> +            mcdserver_state.state =3D RS_IDLE;
> +        } else {
> +            /* copy the content to the line_buf */
> +            mcdserver_state.line_buf[mcdserver_state.line_buf_index++] =
=3D ch;
> +            mcdserver_state.line_sum +=3D ch;
> +        }
> +        break;
> +    case RS_DATAEND:
> +        if (ch =3D=3D TCP_WAS_NOT_LAST) {
> +            reply =3D TCP_ACKNOWLEDGED;
> +            mcd_put_buffer(&reply, 1);
> +            mcdserver_state.state =3D mcd_handle_packet(mcdserver_state.=
line_buf);
> +        } else if (ch =3D=3D TCP_WAS_LAST) {
> +            reply =3D TCP_ACKNOWLEDGED;
> +            mcd_put_buffer(&reply, 1);
> +            mcdserver_state.state =3D mcd_handle_packet(mcdserver_state.=
line_buf);
> +        } else {
> +            /* not acknowledged! */
> +            reply =3D TCP_NOT_ACKNOWLEDGED;
> +            mcd_put_buffer(&reply, 1);
> +            /* waiting for package to get resent */
> +            mcdserver_state.state =3D RS_IDLE;
> +        }
> +        break;
> +    default:
> +        abort();
> +    }
> +}
> +
> +int mcd_handle_packet(const char *line_buf)
> +{
> +    /*
> +     * decides what function (handler) to call depending on
> +     * the first character in the line_buf
> +     */
> +    const MCDCmdParseEntry *cmd_parser =3D NULL;
> +
> +    switch (line_buf[0]) {
> +    default:
> +        /* command not supported */
> +        mcd_put_packet("");
> +        break;
> +    }
> +
> +    if (cmd_parser) {
> +        /* parse commands and run the selected handler function */
> +        run_cmd_parser(line_buf, cmd_parser);
> +    }
> +
> +    return RS_IDLE;
> +}
> +void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd)
> +{
> +    if (!data) {
> +        return;
> +    }
> +
> +    g_string_set_size(mcdserver_state.str_buf, 0);
> +    g_byte_array_set_size(mcdserver_state.mem_buf, 0);
> +
> +    if (process_string_cmd(NULL, data, cmd, 1)) {
> +        mcd_put_packet("");
> +    }
> +}
> +
> +uint64_t atouint64_t(const char *in)
> +{
> +    uint64_t res =3D 0;
> +    for (int i =3D 0; i < strlen(in); ++i) {
> +        const char c =3D in[i];
> +        res *=3D 10;
> +        res +=3D c - '0';
> +    }
> +
> +    return res;
> +}
> +
> +uint32_t atouint32_t(const char *in)
> +{
> +    uint32_t res =3D 0;
> +    for (int i =3D 0; i < strlen(in); ++i) {
> +        const char c =3D in[i];
> +        res *=3D 10;
> +        res +=3D c - '0';
> +    }
> +
> +    return res;
> +}

You could use qemu_strtou64 with error checking instead. We could add
qemu_strtou32 if needed.

> +
> +int cmd_parse_params(const char *data, const char *schema, GArray *param=
s)
> +{
> +
> +    char data_buffer[64] =3D {0};
> +    const char *remaining_data =3D data;
> +
> +    for (int i =3D 0; i < strlen(schema); i++) {
> +        /* get correct part of data */
> +        char *separator =3D strchr(remaining_data, ARGUMENT_SEPARATOR);
> +
> +        if (separator) {
> +            /* multiple arguments */
> +            int seperator_index =3D (int)(separator - remaining_data);
> +            strncpy(data_buffer, remaining_data, seperator_index);
> +            data_buffer[seperator_index] =3D 0;
> +            /* update remaining data for the next run */
> +            remaining_data =3D &(remaining_data[seperator_index + 1]);
> +        } else {
> +            strncpy(data_buffer, remaining_data, strlen(remaining_data));
> +            data_buffer[strlen(remaining_data)] =3D 0;
> +        }
> +
> +        /* store right data */
> +        MCDCmdVariant this_param;
> +        switch (schema[i]) {
> +        case ARG_SCHEMA_STRING:
> +            /* this has to be the last argument */
> +            this_param.data =3D remaining_data;
> +            g_array_append_val(params, this_param);
> +            break;
> +        case ARG_SCHEMA_HEXDATA:
> +            g_string_printf(mcdserver_state.str_buf, "%s", data_buffer);
> +            break;
> +        case ARG_SCHEMA_INT:
> +            this_param.data_uint32_t =3D atouint32_t(data_buffer);
> +            g_array_append_val(params, this_param);
> +            break;
> +        case ARG_SCHEMA_UINT64_T:
> +            this_param.data_uint64_t =3D atouint64_t(data_buffer);
> +            g_array_append_val(params, this_param);
> +            break;
> +        case ARG_SCHEMA_QRYHANDLE:
> +            this_param.query_handle =3D atouint32_t(data_buffer);
> +            g_array_append_val(params, this_param);
> +            break;
> +        case ARG_SCHEMA_CORENUM:
> +            this_param.cpu_id =3D atouint32_t(data_buffer);
> +            g_array_append_val(params, this_param);
> +            break;
> +        default:
> +            return -1;
> +        }
> +    }
> +    return 0;
> +}
> +
> +int process_string_cmd(void *user_ctx, const char *data,
> +    const MCDCmdParseEntry *cmds, int num_cmds)
> +{
> +    int i;
> +    g_autoptr(GArray) params =3D g_array_new(false, true, sizeof(MCDCmdV=
ariant));
> +
> +    if (!cmds) {
> +        return -1;
> +    }
> +
> +    for (i =3D 0; i < num_cmds; i++) {
> +        const MCDCmdParseEntry *cmd =3D &cmds[i];
> +        g_assert(cmd->handler && cmd->cmd);
> +
> +        /* continue if data and command are different */
> +        if (strncmp(data, cmd->cmd, strlen(cmd->cmd))) {
> +            continue;
> +        }
> +
> +        if (strlen(cmd->schema)) {
> +            /* extract data for parameters */
> +            if (cmd_parse_params(&data[strlen(cmd->cmd)], cmd->schema, p=
arams))
> +            {
> +                return -1;
> +            }
> +        }
> +
> +        /* call handler */
> +        cmd->handler(params, user_ctx);
> +        return 0;
> +    }
> +
> +    return -1;
> +}
>=20=20
>  void mcd_chr_event(void *opaque, QEMUChrEvent event)
>  {
> @@ -281,6 +510,43 @@ void mcd_sigterm_handler(int signal)
>  }
>  #endif
>=20=20
> +int mcd_put_packet(const char *buf)
> +{
> +    return mcd_put_packet_binary(buf, strlen(buf));
> +}
> +
> +void mcd_put_strbuf(void)
> +{
> +    mcd_put_packet(mcdserver_state.str_buf->str);
> +}
> +
> +int mcd_put_packet_binary(const char *buf, int len)
> +{
> +    g_byte_array_set_size(mcdserver_state.last_packet, 0);
> +    g_byte_array_append(mcdserver_state.last_packet,
> +        (const uint8_t *) (char[2]) { TCP_COMMAND_START, '\0' }, 1);
> +    g_byte_array_append(mcdserver_state.last_packet,
> +        (const uint8_t *) buf, len);
> +    g_byte_array_append(mcdserver_state.last_packet,
> +        (const uint8_t *) (char[2]) { TCP_COMMAND_END, '\0' }, 1);
> +    g_byte_array_append(mcdserver_state.last_packet,
> +        (const uint8_t *) (char[2]) { TCP_WAS_LAST, '\0' }, 1);
> +
> +    mcd_put_buffer(mcdserver_state.last_packet->data,
> +        mcdserver_state.last_packet->len);
> +    return 0;
> +}
> +
> +void mcd_put_buffer(const uint8_t *buf, int len)
> +{
> +    qemu_chr_fe_write_all(&mcdserver_system_state.chr, buf, len);
> +}
> +
> +MCDProcess *mcd_get_cpu_process(CPUState *cpu)
> +{
> +    return mcd_get_process(mcd_get_cpu_pid(cpu));
> +}
> +
>  uint32_t mcd_get_cpu_pid(CPUState *cpu)
>  {
>      if (cpu->cluster_index =3D=3D UNASSIGNED_CLUSTER_INDEX) {
> @@ -381,3 +647,14 @@ CPUState *find_cpu(uint32_t thread_id)
>      return NULL;
>  }
>=20=20
> +
> +int int_cmp(gconstpointer a, gconstpointer b)
> +{
> +    int int_a =3D *(int *)a;
> +    int int_b =3D *(int *)b;
> +    if (int_a =3D=3D int_b) {
> +        return 0;
> +    } else {
> +        return 1;
> +    }
> +}

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

