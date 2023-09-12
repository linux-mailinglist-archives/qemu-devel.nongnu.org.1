Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C392E79D690
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 18:42:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg6Sv-0004QK-M8; Tue, 12 Sep 2023 12:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg6Su-0004Ps-0q
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:42:16 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg6Sr-0003n4-Ix
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:42:15 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9ad8d47ef2fso93481266b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694536931; x=1695141731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SwYV4N0J6XwvjAWzo7dZiSMGA8mmhbT0PJst4G/NYjk=;
 b=UGLlSUyhf3tUZ5GHlf143sfl4C4WAVj52p16FTAe0hy2Zf4gZdlIkW206WgNd9v3Cf
 1zNQ+7LoKamfX7hgR+82LEf/KI61ySpp+I70YOkt49VIP7N0GTe8ojzUjkOtcdBrkwVj
 JO6jxmtDLLIboyDSPhiQCkSV41Y+uDs152zI6wxI5wtr8YN3IkRF+mePAvsrncBkEoKm
 P/pxsv2HuU2m1KIu2wsWkj8wFCg+eIS3TNYZ9wkEhmApvEooso5293AkYZaScWkPfcYP
 QRCxj6KFkCrnO73Wmqrax3/bfuVZ893SksMfZTQ1fJeDkqueadtI5bV2Z+FHbLtsGBbi
 5OWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694536931; x=1695141731;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SwYV4N0J6XwvjAWzo7dZiSMGA8mmhbT0PJst4G/NYjk=;
 b=Dn1fyxR/tksLqOZ9FU3Xh9y2B4hQZVYTQ0us0n4tnFdVStddmkzqBcnhHEcTkmC7yn
 8u6LLYovcUMNbYQfgEoW3I3aT+oHnqkpflHwPOJb7G8hvllu8ZzKfcWEg8SRVdIk/E+U
 E/Xq97sv6k/NJcfTipwBVnQU547/HAHE2Htww/4u5yUPjxet4KFKM60fGGaztxWkvnNs
 ec62OLn3HWGAHxrmp1/TX0KvmQ2JhQGEco2snyLzRCqv90KLrIly+qaIcQwWmOxulh5h
 OKrTTY0Y8IDN6fIWYMOFnjdeFJktyYZSzG5QAsHxYeV3K8qr6T+DCx47O6zSC7Rl4IpS
 WNiQ==
X-Gm-Message-State: AOJu0YxR+bNouV5Bj2AAX2yae0Xlv96M6e17zAnrbpUiba7G672gMJAb
 dhaHPgUSsVQhMTf2AEwvAR4M4w==
X-Google-Smtp-Source: AGHT+IEMWdKXTw9QNhWyJ4msEW7Spn5B7XmX97Obw5hYIdC1IQf77lCitRGvcwYlzVFSr/wFK6WD+Q==
X-Received: by 2002:a17:906:cc9:b0:99c:5056:4e2e with SMTP id
 l9-20020a1709060cc900b0099c50564e2emr10742974ejh.31.1694536930816; 
 Tue, 12 Sep 2023 09:42:10 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-50-150.dsl.sta.abo.bbox.fr.
 [176.172.50.150]) by smtp.gmail.com with ESMTPSA id
 l18-20020a1709066b9200b009a5f1d15644sm7001348ejr.119.2023.09.12.09.42.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 09:42:10 -0700 (PDT)
Message-ID: <407ab812-9cc4-900b-3641-51d598e93187@linaro.org>
Date: Tue, 12 Sep 2023 18:42:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] tests/avocado: Fix console data loss
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20230912131340.405619-1-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230912131340.405619-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

+Alex who also looked at that IIRC.

On 12/9/23 15:13, Nicholas Piggin wrote:
> Occasionally some avocado tests will fail waiting for console line
> despite the machine running correctly. Console data goes missing, as can
> be seen in the console log. This is due to _console_interaction calling
> makefile() on the console socket each time it is invoked, which must be
> losing old buffer contents when going out of scope.
> 
> It is not enough to makefile() with buffered=0. That helps significantly
> but data loss is still possible. My guess is that readline() has a line
> buffer even when the file is in unbuffered mode, that can eat data.
> 
> Fix this by providing a console file that persists for the life of the
> console.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> 
> For some reason, ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_192m
> was flakey for me due to this bug. I don't know why that in particular,
> 3 calls to wait_for_console_pattern probably helps.
> 
> I didn't pinpoint when the bug was introduced because the original
> was probably not buggy because it was only run once at the end of the
> test. At some point after it was moved to common code, something would
> have started to call it more than once which is where potential for bug
> is introduced.
> 
> Thanks,
> Nick
> 
>   python/qemu/machine/machine.py         | 19 +++++++++++++++++++
>   tests/avocado/avocado_qemu/__init__.py |  2 +-
>   2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
> index c16a0b6fed..35d5a672db 100644
> --- a/python/qemu/machine/machine.py
> +++ b/python/qemu/machine/machine.py
> @@ -191,6 +191,7 @@ def __init__(self,
>               self.sock_dir, f"{self._name}.con"
>           )
>           self._console_socket: Optional[socket.socket] = None
> +        self._console_file: Optional[socket.SocketIO] = None
>           self._remove_files: List[str] = []
>           self._user_killed = False
>           self._quit_issued = False
> @@ -509,6 +510,11 @@ def _early_cleanup(self) -> None:
>           # If we keep the console socket open, we may deadlock waiting
>           # for QEMU to exit, while QEMU is waiting for the socket to
>           # become writable.
> +        if self._console_file is not None:
> +            LOG.debug("Closing console file")
> +            self._console_file.close()
> +            self._console_file = None
> +
>           if self._console_socket is not None:
>               LOG.debug("Closing console socket")
>               self._console_socket.close()
> @@ -874,12 +880,25 @@ def console_socket(self) -> socket.socket:
>           Returns a socket connected to the console
>           """
>           if self._console_socket is None:
> +            LOG.debug("Opening console socket")
>               self._console_socket = console_socket.ConsoleSocket(
>                   self._console_address,
>                   file=self._console_log_path,
>                   drain=self._drain_console)
>           return self._console_socket
>   
> +    @property
> +    def console_file(self) -> socket.SocketIO:
> +        """
> +        Returns a file associated with the console socket
> +        """
> +        if self._console_file is None:
> +            LOG.debug("Opening console file")
> +            self._console_file = self.console_socket.makefile(mode='rb',
> +                                                              buffering=0,
> +                                                              encoding='utf-8')
> +        return self._console_file
> +
>       @property
>       def temp_dir(self) -> str:
>           """
> diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
> index 33090903f1..0172a359b7 100644
> --- a/tests/avocado/avocado_qemu/__init__.py
> +++ b/tests/avocado/avocado_qemu/__init__.py
> @@ -137,7 +137,7 @@ def _console_interaction(test, success_message, failure_message,
>       assert not keep_sending or send_string
>       if vm is None:
>           vm = test.vm
> -    console = vm.console_socket.makefile(mode='rb', encoding='utf-8')
> +    console = vm.console_file
>       console_logger = logging.getLogger('console')
>       while True:
>           if send_string:


