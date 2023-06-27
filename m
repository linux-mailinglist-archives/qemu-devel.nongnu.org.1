Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C2874055C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 23:00:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEFma-0004JI-DS; Tue, 27 Jun 2023 16:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEFmX-0004Ia-Uw
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 16:59:25 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEFmV-0006fm-IN
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 16:59:24 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f957a45b10so6876018e87.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 13:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687899561; x=1690491561;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yidl49e7SEX3FKciW4n8kmUz7l6Uk5DcFSetIMs3Dr8=;
 b=Um1/Yn6fcwXhs+v5nF9abuOe/DteLuM6gHG4wm53p/5DWMCsmSd/lg0V8kfM06o81j
 tGoX/R+HusSbZ3DJNdILm5ezm8IH9HDxn5jQWk7l48/7uY9+NBzQkpftxbB2vWt0q5r9
 Bqlk9T8hTnlOkdAooDNQkUJlshYvHMl3tBHVrZbi3Y6FcfHxkCXIH6yvowfCT9nkU9UP
 sF91vx5/o9JVUyE+X0EOHzi0kU8exs/p7LcjdWK5ItGqKEFZybYbXJ/iMgCDuNxHPplo
 nrkZHgc2LfInUfzBkkYpL33POTcMyL29g1nkncupN8FaoJGMxNaMfMRWjmz9nCUi0sl3
 7FsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687899561; x=1690491561;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yidl49e7SEX3FKciW4n8kmUz7l6Uk5DcFSetIMs3Dr8=;
 b=IwI9bxwvewZigRvzVLOdieAw3fwrIVtgRvtdBoUD0nU2x5XlDGCJpxALCxn98F6BQB
 AUvurd5JKQx6IA3Sfs6ccmNiC2dv1lRH3nN+IZ79da5Yh5xblnfuwZPB743aVPFat83k
 yqf9veJclSBjo1ydcs7aInv6hyLVjmsFNmqtF39wkUCPKuakCKEuXUe+PdN1f3YCttgy
 cLrw/XEAyDDmtjemGnltdNFMuAKob9vtaFUz2POoPjbKrt++MRoN2XHb3Au73I0jCL/P
 XM9RvKTVE2uQDlztYCxgjR9fkiI9Y7WIDjAntaYZnH0G6HHCuojBiKCMKs7w1HpMzZeq
 OHdQ==
X-Gm-Message-State: AC+VfDx/wn7soCUXB3QhKaY7FnqhOfXrYzfYkLd1eFNJTrAnyNv571Q5
 9hUUx6Fqm2NU9zSPR/ztVlb0Yw==
X-Google-Smtp-Source: ACHHUZ7pcyWiHq5LsB0xZ5pckygbSRtDI/tEu5aa716RQG1EEuWA2HvBlLFwojgpVZG3HS9Inpprbw==
X-Received: by 2002:a19:ca16:0:b0:4f8:5ab0:68c4 with SMTP id
 a22-20020a19ca16000000b004f85ab068c4mr16012708lfg.59.1687899560874; 
 Tue, 27 Jun 2023 13:59:20 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 b3-20020aa7cd03000000b0051be5bbce23sm4113903edw.35.2023.06.27.13.59.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 13:59:20 -0700 (PDT)
Message-ID: <d662e5eb-5716-164a-9d06-a105d2ad94a1@linaro.org>
Date: Tue, 27 Jun 2023 22:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 32/36] gdbstub: Expose gdb_get_process() and
 gdb_get_first_cpu_in_process()
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Bandan Das
 <bsd@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
 <20230627160943.2956928-33-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230627160943.2956928-33-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 27/6/23 18:09, Alex Bennée wrote:
> From: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> These functions will be needed by user-target.c in order to retrieve
> the name of the executable.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Message-Id: <20230621203627.1808446-5-iii@linux.ibm.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   gdbstub/internals.h |  2 ++
>   gdbstub/gdbstub.c   | 16 ++++++++--------
>   2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> index 33d21d6488..25e4d5eeaa 100644
> --- a/gdbstub/internals.h
> +++ b/gdbstub/internals.h
> @@ -129,6 +129,8 @@ void gdb_read_byte(uint8_t ch);
>    */
>   bool gdb_got_immediate_ack(void);
>   /* utility helpers */
> +GDBProcess *gdb_get_process(uint32_t pid);
> +CPUState *gdb_get_first_cpu_in_process(GDBProcess *process);

It would be nice to have documentation for public API.
Can be amended later, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   CPUState *gdb_first_attached_cpu(void);
>   void gdb_append_thread_id(CPUState *cpu, GString *buf);
>   int gdb_get_cpu_index(CPUState *cpu);


