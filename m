Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8167E7922DB
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 15:14:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdVse-0008Qy-9u; Tue, 05 Sep 2023 09:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdVsZ-0008QT-Jp
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:14:03 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdVsU-0002Uf-HB
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:14:02 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6bd0a0a6766so1837748a34.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693919636; x=1694524436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6cEBqBaZQ88XNZ7VVcpO8cCgvf4JISyc8QRzi+MLb2s=;
 b=eQUDmBD0TM6KBDLjVub4ZzmR8CmoCNTMq9KooaZ9d6khd1d9cztS9COi1fg3o/iptf
 iV5H7qxa2mp/JnGBfKNHNKuhtczy2jqNCBKeL/M8lLmMsx9XeC8vtipTHl1WfNAK/HJS
 TkT3jTNrVsQStjV/fqIr+HtD63tH/nQQE8CoESMM9bL5+BaPzBloGf+mlzFoMR0j6grY
 4pzIREcG+gLaevYg/c560O5gXfMw+ZwUKJAu584JI5Dw9TMr2x3bMiV9Z69/ErEjLHhZ
 dE4VFxpxMT+dcduozbGzPJLioV2qZuaHElrCW2e0Q0XKaW4zkw3leRqKp+uVcqsWQQ04
 0Cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693919636; x=1694524436;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6cEBqBaZQ88XNZ7VVcpO8cCgvf4JISyc8QRzi+MLb2s=;
 b=MQaFbyvnZzu8fVQoqvoP7UedSwCJx2pHMbl5KmGB6815WjblWV6ybazCpnkCv31zqX
 Qf4Bj2bj+94z0jBzWpi+buYvehmoVsjuidxWUZiQadWHep8NFdOMfdttc0F/fwxhrOV9
 UjgGJcSwNZ33naO7V4qkfknVdmN4QNGoAQw4Zz4sSjJ1hIYaz361y19zJxBbvt+Q4IwR
 NOLp1Qf4aGy9UeByNLNbOriIMXaDuOcKjHAqKyweP9y7BArCikE5o/WoGpSnPPR7J5a1
 k0HBnh4qNaUwdeKUoH24cFl3p4dl/FRd+sz2w83y2fXyXbFpvcFZoXbRqCgr7eJVC/Dz
 PjJw==
X-Gm-Message-State: AOJu0Yx/4hwmD0MRFyWo5hn20riYdefKx5yb3q0Is24A5O/+Q5UnayLb
 BDjsRzXh6lBuwmsNj42Eq7phrt142n2NwAn2TOY=
X-Google-Smtp-Source: AGHT+IE/xSpRtPm2uKAZTODpceb385SalatpT8NvLBOuTQDvu5/dSwq0l/Z+bqT/8BjEDezzgqOgGw==
X-Received: by 2002:a05:6830:1510:b0:6b9:4d79:e08a with SMTP id
 k16-20020a056830151000b006b94d79e08amr14190898otp.32.1693919636434; 
 Tue, 05 Sep 2023 06:13:56 -0700 (PDT)
Received: from [192.168.68.108] ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a9d4f10000000b006b9a9bc7773sm5454706otl.56.2023.09.05.06.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 06:13:56 -0700 (PDT)
Message-ID: <81196607-c2bf-a9c3-3f8c-46af132be80d@ventanamicro.com>
Date: Tue, 5 Sep 2023 10:13:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: 'check-avocado' fails after c03f57fd5b ("Revert "tests: Use
 separate ...")
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <eac059f4-72e2-d1fe-27b2-9657d1777e45@ventanamicro.com>
 <CABgObfYPYH=78UV3gk1m7xv8_=F7KwVxyj9J=uHZ8fCAA6FHmA@mail.gmail.com>
 <CABgObfZGDrKoMZ9oOWHw-Xp0z+Z033bYqW0qyh97h6_h5eno2Q@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CABgObfZGDrKoMZ9oOWHw-Xp0z+Z033bYqW0qyh97h6_h5eno2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x331.google.com
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

Hi,

I managed to work around it. I'll post here the debugs for future reference.

- Here's all the steps after a clean qemu clone:

[danielhb@grind build]$ make check-avocado
   AVOCADO tests/avocado
/home/danielhb/work/test/qemu/build/pyvenv/bin/python3: No module named avocado.__main__; 'avocado' is a package and cannot be directly executed
make: *** [/home/danielhb/work/test/qemu/tests/Makefile.include:139: check-avocado] Error 1
  
[danielhb@grind build]$ V=1 make check-avocado
/home/danielhb/work/test/qemu/build/pyvenv/bin/python3 -B -m avocado --show=app run --job-results-dir=/home/danielhb/work/test/qemu/build/tests/results  --filter-by-tags-include-empty --filter-by-tags-include-empty-key -t arch:riscv64 --failfast tests/avocado
/home/danielhb/work/test/qemu/build/pyvenv/bin/python3: No module named avocado.__main__; 'avocado' is a package and cannot be directly executed
make: *** [/home/danielhb/work/test/qemu/tests/Makefile.include:139: check-avocado] Error 1

[danielhb@grind build]$ cat /home/danielhb/work/test/qemu/build/pyvenv/bin/avocado
#!/home/danielhb/work/test/qemu/build/pyvenv/bin/python3
# -*- coding: utf-8 -*-
import re
import sys
from avocado.core.main import main
if __name__ == '__main__':
     sys.argv[0] = re.sub(r'(-script\.pyw|\.exe)?$', '', sys.argv[0])
     sys.exit(main())
[danielhb@grind build]$

[danielhb@grind build]$ ./pyvenv/bin/python3
Python 3.11.4 (main, Jun  7 2023, 00:00:00) [GCC 13.1.1 20230511 (Red Hat 13.1.1-2)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> from importlib.metadata import distribution
>>> avocado = distribution('avocado-framework')
>>> next((x for x in avocado.entry_points if x.name == 'avocado'))
EntryPoint(name='avocado', value='avocado.core.main:main', group='console_scripts')
>>> 
>>> 

[danielhb@grind build]$ ./pyvenv/bin/avocado --help
Traceback (most recent call last):
   File "/home/danielhb/work/test/qemu/build/./pyvenv/bin/avocado", line 5, in <module>
     from avocado.core.main import main
ModuleNotFoundError: No module named 'avocado.core.main'
[danielhb@grind build]$


- I got suspicious after the above command failure, and noticed that 'avocado' didn't work
even outside of the QEMU tree:


[danielhb@grind ~]$ avocado --help
Traceback (most recent call last):
   File "/usr/bin/avocado", line 33, in <module>
     sys.exit(load_entry_point('avocado-framework==92.0', 'console_scripts', 'avocado')())
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/usr/bin/avocado", line 25, in importlib_load_entry_point
     return next(matches).load()
            ^^^^^^^^^^^^^^^^^^^^
   File "/usr/lib64/python3.11/importlib/metadata/__init__.py", line 202, in load
     module = import_module(match.group('module'))
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/usr/lib64/python3.11/importlib/__init__.py", line 126, in import_module
     return _bootstrap._gcd_import(name[level:], package, level)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "<frozen importlib._bootstrap>", line 1204, in _gcd_import
   File "<frozen importlib._bootstrap>", line 1176, in _find_and_load
   File "<frozen importlib._bootstrap>", line 1140, in _find_and_load_unlocked
ModuleNotFoundError: No module named 'avocado.core.main'


- Turns out that I had 2 avocado versions installed: one from F38 and other from pip.
If I remove the 'pip' version I got a different error:

  (01/13) tests/avocado/empty_cpu_model.py:EmptyCPUModel.test: STARTED
  (06/13) tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_riscv64: ERROR: Test.__init__() got an unexpected keyword argument 'run.results_dir' (0.04 s)
  (...)
  (01/13) tests/avocado/empty_cpu_model.py:EmptyCPUModel.test: ERROR: Test.__init__() got an unexpected keyword argument 'run.results_dir' (0.04 s)
  (...)

- Which seems to be related to a known bug according to:

https://avocado-framework.readthedocs.io/en/101.0/releases/100_1.html


In the end I don't need 'avocado' outside of testing QEMU, so my solution was to
remove all avocado packages from the system and let QEMU install whatever it is
needed inside pyvenv. 'check-avocado' now works in 'master'. I am still unsure
why this particular patch triggered all this problem here, but I don't believe
this is worth pursuing unless other people starts to see problems. For now we
can leave it as is IMO.



Thanks for the help!


Daniel


On 9/5/23 07:49, Paolo Bonzini wrote:
> On Tue, Sep 5, 2023 at 12:39 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> /home/danielhb/work/test/qemu/build/pyvenv/bin/python3 -B python/scripts/mkvenv.py ensuregroup --online /home/danielhb/work/test/qemu/pythondeps.toml avocado
>>> mkvenv: checking for avocado-framework(>=88.1, <93.0)
>>> mkvenv: checking for pycdlib>=1.11.0
>>>     AVOCADO tests/avocado
>>> /home/danielhb/work/test/qemu/build/pyvenv/bin/python3: No module named avocado.__main__; 'avocado' is a package and cannot be directly executed
>>> make: *** [/home/danielhb/work/test/qemu/tests/Makefile.include:139: check-avocado] Error 1
>>
>> Can you run it with "V=1" and also "cat
>> /home/danielhb/work/test/qemu/build/pyvenv/bin/avocado" please?
> 
> Also:
> 
> 1) run the following under the pyvenv/bin/python3 REPL:
> 
> from importlib.metadata import distribution
> avocado = distribution('avocado-framework')
> next((x for x in avocado.entry_points if x.name == 'avocado'))
> 
> FWIW here with a similar system I get
> 
> EntryPoint(name='avocado', value='avocado.core.main:main',
> group='console_scripts')
> 
> 2) try running "pyvenv/bin/avocado --help" and see if it works
> 
> Paolo
> 

