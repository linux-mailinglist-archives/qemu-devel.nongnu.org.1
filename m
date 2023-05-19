Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F173708FF4
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 08:41:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pztm6-0001vf-Pu; Fri, 19 May 2023 02:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pztm3-0001vR-Bz
 for qemu-devel@nongnu.org; Fri, 19 May 2023 02:39:35 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pztm1-0001IJ-A4
 for qemu-devel@nongnu.org; Fri, 19 May 2023 02:39:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-30626f4d74aso1905137f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 23:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684478371; x=1687070371;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5ybzOOkAcQvgZEtV7z2v1diyAGU28AXfQwXlnLM0TI=;
 b=OvioYPvOtByPBaRsqlqukYenbRwu0DUlCu2P2ypZkF0sGWufX/KYAM2M1kkCCAvuxY
 P4jocnVRhgSPcdPs7lEBJBppeg/5oi6SJSsH7DRIuvRCI3vnpJxsxFavjb3lEgbScodF
 0mq23WUqCDAjYeKqOIiTrOVQ1KUjPybeQ86aD81KDYptS96n3Jrc9U2lkoLbk09Pm9Ff
 NcR29Eaa9nJ7o8FUbIG/4D2TsFqkhzTQrTiSfEP4wTc14HPQeZrIyCQTPae1kwZTEz1q
 zOh9f+axm3ewQrNDY1z239rf4BkrvljpFX6LVkA4Bm+mLW9+//V5QEJyuphFO6kKlaxG
 sdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684478371; x=1687070371;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T5ybzOOkAcQvgZEtV7z2v1diyAGU28AXfQwXlnLM0TI=;
 b=evLep+89PvrrVcRLxw7pj1Ft6yCnZxSdqUApKvT7qBmcDhIUGylmmW2y1wjScE+JUK
 kZm+z7mqd/9B2n8MEICKi7Lad52XHwCOg6/0zEmVjCWxCxHQfRelpSHU2d67uxwPc1/K
 0DOseWYd4L0NQK1xrmWJllTURAEjgqbdmDmBnVRvk5OEU+G1w61ifFujGfAcR7m2yR38
 YYJW5L44Nbvd4GcbmPzK9i0Y2gWbB1IO04CvOaKb2A69YLwLGbWDhR6xssgMizB4dPMI
 yDTwjgcnhRUwd9Lo9NuPnLHNKKvvuAT8+P+u+Y2ryjEkQj6tWrfYESetNvHNekmr9pWl
 Fakg==
X-Gm-Message-State: AC+VfDxqVQsHOS/rGbiQ3GE5fuhmVQmsBQ2rgkt/r/KpEr8WZ8OMtqpn
 DERXdZNxn06vd1lm1hIKXU/PSQ==
X-Google-Smtp-Source: ACHHUZ7m0vFmOpdtPAZ8wo5D1vVrTcKwKlKK29vV+ewRVvC4ln45QeJFdpckuEAkDfYlTq6kksF8eA==
X-Received: by 2002:a5d:68cd:0:b0:307:83a4:5860 with SMTP id
 p13-20020a5d68cd000000b0030783a45860mr892939wrw.68.1684478371416; 
 Thu, 18 May 2023 23:39:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a5d644f000000b00307a83ea722sm4252831wrw.58.2023.05.18.23.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 23:39:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 496801FFBB;
 Fri, 19 May 2023 07:39:30 +0100 (BST)
References: <20230518162034.1277885-1-alex.bennee@linaro.org>
 <20230518162034.1277885-8-alex.bennee@linaro.org>
 <CAFn=p-YLTqv6bQGi9xFeZ1fCw71EdqiTLw2xv2yWnJmWfzw+vQ@mail.gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?Dan?=
 =?utf-8?Q?iel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, =?utf-8?Q?Marc-?=
 =?utf-8?Q?Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Cleber Rosa <crosa@redhat.com>, Beraldo Leal
 <bleal@redhat.com>
Subject: Re: [PATCH 7/8] python/qemu: allow avocado to set logging name space
Date: Fri, 19 May 2023 07:38:13 +0100
In-reply-to: <CAFn=p-YLTqv6bQGi9xFeZ1fCw71EdqiTLw2xv2yWnJmWfzw+vQ@mail.gmail.com>
Message-ID: <87o7mglt99.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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


John Snow <jsnow@redhat.com> writes:

> On Thu, May 18, 2023 at 12:20=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@li=
naro.org> wrote:
>>
>> Since the update to the latest version Avocado only automatically
>> collects logging under the avocado name space. Tweak the QEMUMachine
>> class to allow avocado to bring logging under its name space. This
>> also allows useful tricks like:
>>
>>   ./avocado --show avocado.qemu.machine run path/to/test
>>
>> if you want to quickly get the machine invocation out of a test
>> without searching deeply through the logs.
>>
>
> Huh. That's kind of weird though, right? Each Python module is
> intended to log to its own namespace by design; it feels like Avocado
> really ought to have configuration options that allows it to collect
> logging from other namespaces. I'm not against this patch, but if for
> instance I wind up splitting qemu.machine out as a separate module
> someday (like I did to qemu.qmp), then it feels weird to add options
> specifically for fudging the logging hierarchy.

According to the docs it does but I couldn't get it to work so this is a
sticking plaster over that. If it gets fixed in later avocado's it is
easy enough to remove.

> Also, what about the QMP logging? I don't suppose this will trickle
> down to that level either.

I can certainly add that - but it would need a similar hook.

>
> Worried this is kind of incomplete.
>
> --js
>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  python/qemu/machine/machine.py         | 42 ++++++++++++++------------
>>  tests/avocado/avocado_qemu/__init__.py |  3 +-
>>  2 files changed, 24 insertions(+), 21 deletions(-)
>>
>> diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machin=
e.py
>> index e57c254484..402b9a0df9 100644
>> --- a/python/qemu/machine/machine.py
>> +++ b/python/qemu/machine/machine.py
>> @@ -49,10 +49,6 @@
>>
>>  from . import console_socket
>>
>> -
>> -LOG =3D logging.getLogger(__name__)
>> -
>> -
>>  class QEMUMachineError(Exception):
>>      """
>>      Exception called when an error in QEMUMachine happens.
>> @@ -131,6 +127,7 @@ def __init__(self,
>>                   drain_console: bool =3D False,
>>                   console_log: Optional[str] =3D None,
>>                   log_dir: Optional[str] =3D None,
>> +                 log_namespace: Optional[str] =3D None,
>>                   qmp_timer: Optional[float] =3D 30):
>>          '''
>>          Initialize a QEMUMachine
>> @@ -164,6 +161,11 @@ def __init__(self,
>>          self._sock_dir =3D sock_dir
>>          self._log_dir =3D log_dir
>>
>> +        if log_namespace:
>> +            self.log =3D logging.getLogger(log_namespace)
>> +        else:
>> +            self.log =3D logging.getLogger(__name__)
>> +
>>          self._monitor_address =3D monitor_address
>>
>>          self._console_log_path =3D console_log
>> @@ -382,11 +384,11 @@ def _post_shutdown(self) -> None:
>>          Called to cleanup the VM instance after the process has exited.
>>          May also be called after a failed launch.
>>          """
>> -        LOG.debug("Cleaning up after VM process")
>> +        self.log.debug("Cleaning up after VM process")
>>          try:
>>              self._close_qmp_connection()
>>          except Exception as err:  # pylint: disable=3Dbroad-except
>> -            LOG.warning(
>> +            self.log.warning(
>>                  "Exception closing QMP connection: %s",
>>                  str(err) if str(err) else type(err).__name__
>>              )
>> @@ -414,7 +416,7 @@ def _post_shutdown(self) -> None:
>>                  command =3D ' '.join(self._qemu_full_args)
>>              else:
>>                  command =3D ''
>> -            LOG.warning(msg, -int(exitcode), command)
>> +            self.log.warning(msg, -int(exitcode), command)
>>
>>          self._quit_issued =3D False
>>          self._user_killed =3D False
>> @@ -458,7 +460,7 @@ def _launch(self) -> None:
>>          Launch the VM and establish a QMP connection
>>          """
>>          self._pre_launch()
>> -        LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_arg=
s))
>> +        self.log.debug('VM launch command: %r', ' '.join(self._qemu_ful=
l_args))
>>
>>          # Cleaning up of this subprocess is guaranteed by _do_shutdown.
>>          # pylint: disable=3Dconsider-using-with
>> @@ -507,7 +509,7 @@ def _early_cleanup(self) -> None:
>>          # for QEMU to exit, while QEMU is waiting for the socket to
>>          # become writable.
>>          if self._console_socket is not None:
>> -            LOG.debug("Closing console socket")
>> +            self.log.debug("Closing console socket")
>>              self._console_socket.close()
>>              self._console_socket =3D None
>>
>> @@ -518,7 +520,7 @@ def _hard_shutdown(self) -> None:
>>          :raise subprocess.Timeout: When timeout is exceeds 60 seconds
>>              waiting for the QEMU process to terminate.
>>          """
>> -        LOG.debug("Performing hard shutdown")
>> +        self.log.debug("Performing hard shutdown")
>>          self._early_cleanup()
>>          self._subp.kill()
>>          self._subp.wait(timeout=3D60)
>> @@ -535,17 +537,17 @@ def _soft_shutdown(self, timeout: Optional[int]) -=
> None:
>>          :raise subprocess.TimeoutExpired: When timeout is exceeded wait=
ing for
>>              the QEMU process to terminate.
>>          """
>> -        LOG.debug("Attempting graceful termination")
>> +        self.log.debug("Attempting graceful termination")
>>
>>          self._early_cleanup()
>>
>>          if self._quit_issued:
>> -            LOG.debug(
>> +            self.log.debug(
>>                  "Anticipating QEMU termination due to prior 'quit' comm=
and, "
>>                  "or explicit call to wait()"
>>              )
>>          else:
>> -            LOG.debug("Politely asking QEMU to terminate")
>> +            self.log.debug("Politely asking QEMU to terminate")
>>
>>          if self._qmp_connection:
>>              try:
>> @@ -557,14 +559,14 @@ def _soft_shutdown(self, timeout: Optional[int]) -=
> None:
>>                  # Regardless, we want to quiesce the connection.
>>                  self._close_qmp_connection()
>>          elif not self._quit_issued:
>> -            LOG.debug(
>> +            self.log.debug(
>>                  "Not anticipating QEMU quit and no QMP connection prese=
nt, "
>>                  "issuing SIGTERM"
>>              )
>>              self._subp.terminate()
>>
>>          # May raise subprocess.TimeoutExpired
>> -        LOG.debug(
>> +        self.log.debug(
>>              "Waiting (timeout=3D%s) for QEMU process (pid=3D%s) to term=
inate",
>>              timeout, self._subp.pid
>>          )
>> @@ -586,9 +588,9 @@ def _do_shutdown(self, timeout: Optional[int]) -> No=
ne:
>>              self._soft_shutdown(timeout)
>>          except Exception as exc:
>>              if isinstance(exc, subprocess.TimeoutExpired):
>> -                LOG.debug("Timed out waiting for QEMU process to exit")
>> -            LOG.debug("Graceful shutdown failed", exc_info=3DTrue)
>> -            LOG.debug("Falling back to hard shutdown")
>> +                self.log.debug("Timed out waiting for QEMU process to e=
xit")
>> +            self.log.debug("Graceful shutdown failed", exc_info=3DTrue)
>> +            self.log.debug("Falling back to hard shutdown")
>>              self._hard_shutdown()
>>              raise AbnormalShutdown("Could not perform graceful shutdown=
") \
>>                  from exc
>> @@ -611,9 +613,9 @@ def shutdown(self,
>>          if not self._launched:
>>              return
>>
>> -        LOG.debug("Shutting down VM appliance; timeout=3D%s", timeout)
>> +        self.log.debug("Shutting down VM appliance; timeout=3D%s", time=
out)
>>          if hard:
>> -            LOG.debug("Caller requests immediate termination of QEMU pr=
ocess.")
>> +            self.log.debug("Caller requests immediate termination of QE=
MU process.")
>>
>>          try:
>>              if hard:
>> diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avoc=
ado_qemu/__init__.py
>> index b19f797b7b..d925573299 100644
>> --- a/tests/avocado/avocado_qemu/__init__.py
>> +++ b/tests/avocado/avocado_qemu/__init__.py
>> @@ -322,7 +322,8 @@ def require_multiprocess(self):
>>      def _new_vm(self, name, *args):
>>          self._sd =3D tempfile.TemporaryDirectory(prefix=3D"qemu_")
>>          vm =3D QEMUMachine(self.qemu_bin, base_temp_dir=3Dself.workdir,
>> -                         sock_dir=3Dself._sd.name, log_dir=3Dself.logdi=
r)
>> +                         sock_dir=3Dself._sd.name, log_dir=3Dself.logdi=
r,
>> +                         log_namespace=3D"avocado.qemu.machine")
>>          self.log.debug('QEMUMachine "%s" created', name)
>>          self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_d=
ir)
>>          self.log.debug('QEMUMachine "%s" log_dir: %s', name, vm.log_dir)
>> --
>> 2.39.2
>>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

