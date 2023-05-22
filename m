Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8F270C5D9
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:13:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1AxL-0005eQ-0C; Mon, 22 May 2023 15:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q1Ax3-0005CU-AG
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:12:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q1Ax0-0005Ib-2K
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684782726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VfEywYsBeQT2PWYZhGBSDUVT7Gi+JZYdGtYNtSdy13o=;
 b=ZQ2DnQPf8TsT0DuAuVUChddKl4drIbDwpo/1Y6eGKqnFhGqhwDc9IoHq0/h5sBaNWZaMvJ
 YhwdsxQpa5DvF0sLJO22vozyd0Z3mhGy97DU5WCMd2uK+dXukXKQnmGspuEO1oDDV53v0D
 +AGcv19tPnqEMPwnSUDDDaQCSniTre4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-_4kM5VAAMwmG_j_KEOhQPw-1; Mon, 22 May 2023 15:12:05 -0400
X-MC-Unique: _4kM5VAAMwmG_j_KEOhQPw-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1ae8ed0a9dfso15352135ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 12:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684782724; x=1687374724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VfEywYsBeQT2PWYZhGBSDUVT7Gi+JZYdGtYNtSdy13o=;
 b=MCh1qA6I2UceaT/DvDKQd6v2xzh6bpi0kHwuyZPzzgJ5tj4GTx1w52WWcXddajzNsz
 zWwkahsgCfcBuydFfzpHgscfN542AVycL8pgTO7fi0yNEh091EtFhv13SiryoLMJT1TI
 ay90OCJllS9GVC1rtfmBFPUHE186QGa6TUV6gxrh5BAs/Vj424u47EIDo9+Qs1k4lOb7
 4iLpQ9uIS/0vkCkejBB/drOZYZfVLGvCc8Kle3ADlR3cpmfyc+qAJJSmvMGBdXHY7EkJ
 vuMKtd8ETAzWeQv3kV2RpD00CTtB/eJOe4deTWWoOH/w2AXy9BcdYumuDHfQ2duOdb3G
 FtUg==
X-Gm-Message-State: AC+VfDxk4EkZgXm0hVLefmBWtumwQzuqtJ691i1QRPa1pEjIZ357GnAq
 LNUm8J2ZWsx3//K5pnNNVcpduxhtJqLY+q3agYwZFEC9yiDMnI7WOg3/kNnhDri06Lqwm7KSQEv
 v/ZeI0Dr7bva4CUVu0UXfaCYtnwutStk=
X-Received: by 2002:a17:902:e74a:b0:1af:c0b9:d962 with SMTP id
 p10-20020a170902e74a00b001afc0b9d962mr1542491plf.24.1684782724437; 
 Mon, 22 May 2023 12:12:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4puve1s/GK6fh6OolbnN0Oda31Xp5+hp3r+EFkGiphtT4SZUmJUrszrsJUkWF0qhBD7QS20KOKqq6eQIblkgk=
X-Received: by 2002:a17:902:e74a:b0:1af:c0b9:d962 with SMTP id
 p10-20020a170902e74a00b001afc0b9d962mr1542459plf.24.1684782724045; Mon, 22
 May 2023 12:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230518162034.1277885-1-alex.bennee@linaro.org>
 <20230518162034.1277885-8-alex.bennee@linaro.org>
 <CAFn=p-YLTqv6bQGi9xFeZ1fCw71EdqiTLw2xv2yWnJmWfzw+vQ@mail.gmail.com>
 <87o7mglt99.fsf@linaro.org>
In-Reply-To: <87o7mglt99.fsf@linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 22 May 2023 15:11:52 -0400
Message-ID: <CAFn=p-aiXNLM==RGqkYSeKO3UridfWBX0ExgWOC5G9HevBHaxA@mail.gmail.com>
Subject: Re: [PATCH 7/8] python/qemu: allow avocado to set logging name space
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 19, 2023 at 2:39=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
>
> John Snow <jsnow@redhat.com> writes:
>
> > On Thu, May 18, 2023 at 12:20=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@=
linaro.org> wrote:
> >>
> >> Since the update to the latest version Avocado only automatically
> >> collects logging under the avocado name space. Tweak the QEMUMachine
> >> class to allow avocado to bring logging under its name space. This
> >> also allows useful tricks like:
> >>
> >>   ./avocado --show avocado.qemu.machine run path/to/test
> >>
> >> if you want to quickly get the machine invocation out of a test
> >> without searching deeply through the logs.
> >>
> >
> > Huh. That's kind of weird though, right? Each Python module is
> > intended to log to its own namespace by design; it feels like Avocado
> > really ought to have configuration options that allows it to collect
> > logging from other namespaces. I'm not against this patch, but if for
> > instance I wind up splitting qemu.machine out as a separate module
> > someday (like I did to qemu.qmp), then it feels weird to add options
> > specifically for fudging the logging hierarchy.
>
> According to the docs it does but I couldn't get it to work so this is a
> sticking plaster over that. If it gets fixed in later avocado's it is
> easy enough to remove.
>

Fair enough ...

Cleber, any input?

> > Also, what about the QMP logging? I don't suppose this will trickle
> > down to that level either.
>
> I can certainly add that - but it would need a similar hook.

Right... this is why I am wondering if it isn't just simpler to
configure Avocado to just relay everything from the qemu.* namespace,
which will be easier in the long run ... but hey, if it's broken, it's
broken :(

ACK to the bandaid.

--js

>
> >
> > Worried this is kind of incomplete.
> >
> > --js
> >
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> ---
> >>  python/qemu/machine/machine.py         | 42 ++++++++++++++-----------=
-
> >>  tests/avocado/avocado_qemu/__init__.py |  3 +-
> >>  2 files changed, 24 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/mach=
ine.py
> >> index e57c254484..402b9a0df9 100644
> >> --- a/python/qemu/machine/machine.py
> >> +++ b/python/qemu/machine/machine.py
> >> @@ -49,10 +49,6 @@
> >>
> >>  from . import console_socket
> >>
> >> -
> >> -LOG =3D logging.getLogger(__name__)
> >> -
> >> -
> >>  class QEMUMachineError(Exception):
> >>      """
> >>      Exception called when an error in QEMUMachine happens.
> >> @@ -131,6 +127,7 @@ def __init__(self,
> >>                   drain_console: bool =3D False,
> >>                   console_log: Optional[str] =3D None,
> >>                   log_dir: Optional[str] =3D None,
> >> +                 log_namespace: Optional[str] =3D None,
> >>                   qmp_timer: Optional[float] =3D 30):
> >>          '''
> >>          Initialize a QEMUMachine
> >> @@ -164,6 +161,11 @@ def __init__(self,
> >>          self._sock_dir =3D sock_dir
> >>          self._log_dir =3D log_dir
> >>
> >> +        if log_namespace:
> >> +            self.log =3D logging.getLogger(log_namespace)
> >> +        else:
> >> +            self.log =3D logging.getLogger(__name__)
> >> +
> >>          self._monitor_address =3D monitor_address
> >>
> >>          self._console_log_path =3D console_log
> >> @@ -382,11 +384,11 @@ def _post_shutdown(self) -> None:
> >>          Called to cleanup the VM instance after the process has exite=
d.
> >>          May also be called after a failed launch.
> >>          """
> >> -        LOG.debug("Cleaning up after VM process")
> >> +        self.log.debug("Cleaning up after VM process")
> >>          try:
> >>              self._close_qmp_connection()
> >>          except Exception as err:  # pylint: disable=3Dbroad-except
> >> -            LOG.warning(
> >> +            self.log.warning(
> >>                  "Exception closing QMP connection: %s",
> >>                  str(err) if str(err) else type(err).__name__
> >>              )
> >> @@ -414,7 +416,7 @@ def _post_shutdown(self) -> None:
> >>                  command =3D ' '.join(self._qemu_full_args)
> >>              else:
> >>                  command =3D ''
> >> -            LOG.warning(msg, -int(exitcode), command)
> >> +            self.log.warning(msg, -int(exitcode), command)
> >>
> >>          self._quit_issued =3D False
> >>          self._user_killed =3D False
> >> @@ -458,7 +460,7 @@ def _launch(self) -> None:
> >>          Launch the VM and establish a QMP connection
> >>          """
> >>          self._pre_launch()
> >> -        LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_a=
rgs))
> >> +        self.log.debug('VM launch command: %r', ' '.join(self._qemu_f=
ull_args))
> >>
> >>          # Cleaning up of this subprocess is guaranteed by _do_shutdow=
n.
> >>          # pylint: disable=3Dconsider-using-with
> >> @@ -507,7 +509,7 @@ def _early_cleanup(self) -> None:
> >>          # for QEMU to exit, while QEMU is waiting for the socket to
> >>          # become writable.
> >>          if self._console_socket is not None:
> >> -            LOG.debug("Closing console socket")
> >> +            self.log.debug("Closing console socket")
> >>              self._console_socket.close()
> >>              self._console_socket =3D None
> >>
> >> @@ -518,7 +520,7 @@ def _hard_shutdown(self) -> None:
> >>          :raise subprocess.Timeout: When timeout is exceeds 60 seconds
> >>              waiting for the QEMU process to terminate.
> >>          """
> >> -        LOG.debug("Performing hard shutdown")
> >> +        self.log.debug("Performing hard shutdown")
> >>          self._early_cleanup()
> >>          self._subp.kill()
> >>          self._subp.wait(timeout=3D60)
> >> @@ -535,17 +537,17 @@ def _soft_shutdown(self, timeout: Optional[int])=
 -> None:
> >>          :raise subprocess.TimeoutExpired: When timeout is exceeded wa=
iting for
> >>              the QEMU process to terminate.
> >>          """
> >> -        LOG.debug("Attempting graceful termination")
> >> +        self.log.debug("Attempting graceful termination")
> >>
> >>          self._early_cleanup()
> >>
> >>          if self._quit_issued:
> >> -            LOG.debug(
> >> +            self.log.debug(
> >>                  "Anticipating QEMU termination due to prior 'quit' co=
mmand, "
> >>                  "or explicit call to wait()"
> >>              )
> >>          else:
> >> -            LOG.debug("Politely asking QEMU to terminate")
> >> +            self.log.debug("Politely asking QEMU to terminate")
> >>
> >>          if self._qmp_connection:
> >>              try:
> >> @@ -557,14 +559,14 @@ def _soft_shutdown(self, timeout: Optional[int])=
 -> None:
> >>                  # Regardless, we want to quiesce the connection.
> >>                  self._close_qmp_connection()
> >>          elif not self._quit_issued:
> >> -            LOG.debug(
> >> +            self.log.debug(
> >>                  "Not anticipating QEMU quit and no QMP connection pre=
sent, "
> >>                  "issuing SIGTERM"
> >>              )
> >>              self._subp.terminate()
> >>
> >>          # May raise subprocess.TimeoutExpired
> >> -        LOG.debug(
> >> +        self.log.debug(
> >>              "Waiting (timeout=3D%s) for QEMU process (pid=3D%s) to te=
rminate",
> >>              timeout, self._subp.pid
> >>          )
> >> @@ -586,9 +588,9 @@ def _do_shutdown(self, timeout: Optional[int]) -> =
None:
> >>              self._soft_shutdown(timeout)
> >>          except Exception as exc:
> >>              if isinstance(exc, subprocess.TimeoutExpired):
> >> -                LOG.debug("Timed out waiting for QEMU process to exit=
")
> >> -            LOG.debug("Graceful shutdown failed", exc_info=3DTrue)
> >> -            LOG.debug("Falling back to hard shutdown")
> >> +                self.log.debug("Timed out waiting for QEMU process to=
 exit")
> >> +            self.log.debug("Graceful shutdown failed", exc_info=3DTru=
e)
> >> +            self.log.debug("Falling back to hard shutdown")
> >>              self._hard_shutdown()
> >>              raise AbnormalShutdown("Could not perform graceful shutdo=
wn") \
> >>                  from exc
> >> @@ -611,9 +613,9 @@ def shutdown(self,
> >>          if not self._launched:
> >>              return
> >>
> >> -        LOG.debug("Shutting down VM appliance; timeout=3D%s", timeout=
)
> >> +        self.log.debug("Shutting down VM appliance; timeout=3D%s", ti=
meout)
> >>          if hard:
> >> -            LOG.debug("Caller requests immediate termination of QEMU =
process.")
> >> +            self.log.debug("Caller requests immediate termination of =
QEMU process.")
> >>
> >>          try:
> >>              if hard:
> >> diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/av=
ocado_qemu/__init__.py
> >> index b19f797b7b..d925573299 100644
> >> --- a/tests/avocado/avocado_qemu/__init__.py
> >> +++ b/tests/avocado/avocado_qemu/__init__.py
> >> @@ -322,7 +322,8 @@ def require_multiprocess(self):
> >>      def _new_vm(self, name, *args):
> >>          self._sd =3D tempfile.TemporaryDirectory(prefix=3D"qemu_")
> >>          vm =3D QEMUMachine(self.qemu_bin, base_temp_dir=3Dself.workdi=
r,
> >> -                         sock_dir=3Dself._sd.name, log_dir=3Dself.log=
dir)
> >> +                         sock_dir=3Dself._sd.name, log_dir=3Dself.log=
dir,
> >> +                         log_namespace=3D"avocado.qemu.machine")
> >>          self.log.debug('QEMUMachine "%s" created', name)
> >>          self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp=
_dir)
> >>          self.log.debug('QEMUMachine "%s" log_dir: %s', name, vm.log_d=
ir)
> >> --
> >> 2.39.2
> >>
>


