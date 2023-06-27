Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7DE740569
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 23:01:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEFo5-000597-Ga; Tue, 27 Jun 2023 17:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEFo3-00058n-DI
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 17:00:59 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEFo1-0007Lt-QS
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 17:00:59 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51da8340ab4so487199a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687899656; x=1690491656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=62OSSH3ozCHJnLQunVKnxmuqfOzJ18O1VXRziuXTiLM=;
 b=g1gW2Y6O0heT+yKFj7xlC4nF2pldWT61vL1IOzyIZGlqB+8fwfPhD2vGUDpi4jYC74
 mML9hEVszJMi5oaUDPkhNHueP0NtWllgP/H5PWAI5l+sc8QVX4cJm/VpFqep8qZAvqYB
 v0YY4Q5NlqJVXL1ZnUkQRo/utVzUKH0iUdYo+OwFUj7RSu4tfvrk5sVKJA3EloWQhb4u
 WdlL6cFPK//IP/9ocjtoFMFgEPKwFUiD3InChJL4TVuCSLadHQ5WqNmoCvAcz6Xu7zRv
 A8LLhbdfYc8v9NL9F/HWWYNPLZdmbOatlcX1+fG0D8GCLQlxXw2r8LU+eFb9+G2XxLCx
 sNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687899656; x=1690491656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=62OSSH3ozCHJnLQunVKnxmuqfOzJ18O1VXRziuXTiLM=;
 b=jFD8y1MaFLPhxi+p8Ugk9DCznTyTypb90NsQOaboUYmg1asKFDfzMf5WqO58rzflHG
 ytcwk//FhMyJS2INjQ3dLX7YGmftiCX7mFUf+bA8NWhw4ggY00kYVJc/bREcHEhmjyNj
 rz2n/VjNEFY+J5jt5HsPCAEH8VcVgkHkFyK7mnRzX1AWGLEMHmil5AVsLclYk2VVKLiO
 LH90Dd9eOn36pbQjAwqzAbKERXQjKliUMkKY9Qg37/hpngSA7cZkrLDlXvTpFzUqLdhR
 bYlQNIG3AUMcc9yI3STols81IbcbERdEjIHziwGUY1pigeZilesV7JZ2zjZnmJADAOZe
 CG4A==
X-Gm-Message-State: AC+VfDyzLJc5bJiwOugpicbMOwcMFJ9ae0xrTU1fkkBpCwRs6CIhdflX
 gJPwzyNnunZYmKZF68J0FgkP2A==
X-Google-Smtp-Source: ACHHUZ6a28yMQWprkLI3xYQWX5l/FZWh2yD+hy1eusXwXMqEC/1E4Z/TEPD5zK1Gyphu7CFdUwZRRA==
X-Received: by 2002:a17:907:1ca8:b0:973:84b0:b077 with SMTP id
 nb40-20020a1709071ca800b0097384b0b077mr33552419ejc.33.1687899656108; 
 Tue, 27 Jun 2023 14:00:56 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a170906050900b00989027eb30asm4922722eja.158.2023.06.27.14.00.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 14:00:55 -0700 (PDT)
Message-ID: <db947a1b-dab5-e8df-98ee-f794d4f377ce@linaro.org>
Date: Tue, 27 Jun 2023 23:00:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 35/36] docs: Document security implications of debugging
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
 <20230627160943.2956928-36-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230627160943.2956928-36-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 27/6/23 18:09, Alex Bennée wrote:
> From: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> Now that the GDB stub explicitly implements reading host files (note
> that it was already possible by changing the emulated code to open and
> read those files), concerns may arise that it undermines security.
> 
> Document the status quo, which is that the users are already
> responsible for securing the GDB connection themselves.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Message-Id: <20230621203627.1808446-8-iii@linux.ibm.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/system/gdb.rst | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


