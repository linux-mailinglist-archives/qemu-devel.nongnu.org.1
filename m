Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5277A8DCA
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:30:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3oy-0004G4-Oz; Wed, 20 Sep 2023 16:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3os-0004Fn-Vs
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3ol-00004t-Lm
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695241741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wymh0Xfbmqk7I7AQPS+cfaP/yLQInSQDYUz17PqlD6U=;
 b=Nu9irbcuoxyRq1uLfNZdO7Tc2U/IHRVA7r+H0HmlHkzLV5rnU0jiWiqV4VOHPVz6e78Bxi
 mYHsFCevX6H2LdNs+qS3uktQPRAsUMrFEOwEBnq7J+pRTIkLkupaGYpPR20TOVT8ph2SCM
 vNbZ3xZCyTslylylwV9qcLjv9k1S7qs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-4PZvB2V2O4e9OXC3R4Nc-g-1; Wed, 20 Sep 2023 16:28:58 -0400
X-MC-Unique: 4PZvB2V2O4e9OXC3R4Nc-g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C46042999B3B;
 Wed, 20 Sep 2023 20:28:57 +0000 (UTC)
Received: from localhost (unknown [10.39.193.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22157492C37;
 Wed, 20 Sep 2023 20:28:56 +0000 (UTC)
Date: Wed, 20 Sep 2023 16:28:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
Subject: Re: [PATCH v4 12/14] simpletrace: added simplified Analyzer2 class
Message-ID: <20230920202855.GL1094271@fedora>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-13-mads@ynddal.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VDjLFN1ZXrU4TIHr"
Content-Disposition: inline
In-Reply-To: <20230823085429.20519-13-mads@ynddal.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--VDjLFN1ZXrU4TIHr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:54:27AM +0200, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
>=20
> By moving the dynamic argument construction to keyword-arguments,
> we can remove all of the specialized handling, and streamline it.
> If a tracing method wants to access these, they can define the
> kwargs, or ignore it be placing `**kwargs` at the end of the
> function's arguments list.
>=20
> Added deprecation warning to Analyzer class to make users aware
> of the Analyzer2 class. No removal date is planned.
>=20
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>  scripts/simpletrace-benchmark.zip | Bin 0 -> 4809 bytes
>  scripts/simpletrace.py            |  78 +++++++++++++++++++++++++++++-
>  2 files changed, 76 insertions(+), 2 deletions(-)
>  create mode 100644 scripts/simpletrace-benchmark.zip
>=20
> diff --git a/scripts/simpletrace-benchmark.zip b/scripts/simpletrace-benc=
hmark.zip
> new file mode 100644
> index 0000000000000000000000000000000000000000..1d696a8d5c49d4725c938af8b=
f25a59090192986
> GIT binary patch
> literal 4809
> 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
> DD^M;a
>=20
> literal 0
> HcmV?d00001
>=20
> diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
> index 4136d00600..fdeeed7cd6 100755
> --- a/scripts/simpletrace.py
> +++ b/scripts/simpletrace.py
> @@ -12,10 +12,11 @@
>  import sys
>  import struct
>  import inspect
> +import warnings
>  from tracetool import read_events, Event
>  from tracetool.backend.simple import is_string
> =20
> -__all__ =3D ['Analyzer', 'process', 'run']
> +__all__ =3D ['Analyzer', 'Analyzer2', 'process', 'run']
> =20
>  # This is the binary format that the QEMU "simple" trace backend
>  # emits. There is no specification documentation because the format is
> @@ -130,7 +131,9 @@ def read_trace_records(events, fobj, read_header):
>              yield (event_mapping[event_name], event_name, timestamp_ns, =
pid) + tuple(args)
> =20
>  class Analyzer:
> -    """A trace file analyzer which processes trace records.
> +    """[Deprecated. Refer to Analyzer2 instead.]
> +
> +    A trace file analyzer which processes trace records.
> =20
>      An analyzer can be passed to run() or process().  The begin() method=
 is
>      invoked, then each trace record is processed, and finally the end() =
method
> @@ -188,6 +191,11 @@ def _build_fn(self, event):
>              return lambda _, rec: fn(*rec[3:3 + event_argcount])
> =20
>      def _process_event(self, rec_args, *, event, event_id, timestamp_ns,=
 pid, **kwargs):
> +        warnings.warn(
> +            "Use of deprecated Analyzer class. Refer to Analyzer2 instea=
d.",
> +            DeprecationWarning,
> +        )
> +
>          if not hasattr(self, '_fn_cache'):
>              # NOTE: Cannot depend on downstream subclasses to have
>              # super().__init__() because of legacy.
> @@ -211,6 +219,56 @@ def __exit__(self, exc_type, exc_val, exc_tb):
>              self.end()
>          return False
> =20
> +class Analyzer2(Analyzer):
> +    """A trace file analyzer which processes trace records.
> +
> +    An analyzer can be passed to run() or process().  The begin() method=
 is
> +    invoked, then each trace record is processed, and finally the end() =
method
> +    is invoked. When Analyzer is used as a context-manager (using the `w=
ith`
> +    statement), begin() and end() are called automatically.
> +
> +    If a method matching a trace event name exists, it is invoked to pro=
cess
> +    that trace record.  Otherwise the catchall() method is invoked.
> +
> +    The methods are called with a set of keyword-arguments. These can be=
 ignored
> +    using `**kwargs` or defined like any keyword-argument.
> +
> +    The following keyword-arguments are available, but make sure to have=
 an
> +    **kwargs to allow for unmatched arguments in the future:
> +        event: Event object of current trace
> +        event_id: The id of the event in the current trace file
> +        timestamp_ns: The timestamp in nanoseconds of the trace
> +        pid: The process id recorded for the given trace
> +
> +    Example:
> +    The following method handles the runstate_set(int new_state) trace e=
vent::
> +
> +      def runstate_set(self, new_state, **kwargs):
> +          ...
> +
> +    The method can also explicitly take a timestamp keyword-argument wit=
h the
> +    trace event arguments::
> +
> +      def runstate_set(self, new_state, *, timestamp_ns, **kwargs):
> +          ...
> +
> +    Timestamps have the uint64_t type and are in nanoseconds.
> +
> +    The pid can be included in addition to the timestamp and is useful w=
hen
> +    dealing with traces from multiple processes:
> +
> +      def runstate_set(self, new_state, *, timestamp_ns, pid, **kwargs):
> +          ...
> +    """
> +
> +    def catchall(self, *rec_args, event, timestamp_ns, pid, event_id, **=
kwargs):
> +        """Called if no specific method for processing a trace event has=
 been found."""
> +        pass
> +
> +    def _process_event(self, rec_args, *, event, **kwargs):
> +        fn =3D getattr(self, event.name, self.catchall)
> +        fn(*rec_args, event=3Devent, **kwargs)
> +
>  def process(events, log, analyzer, read_header=3DTrue):
>      """Invoke an analyzer on each event in a log.
>      Args:
> @@ -300,6 +358,22 @@ def catchall(self, event, rec):
>                  i +=3D 1
>              print(' '.join(fields))
> =20
> +    class Formatter2(Analyzer2):

Was this class part of the benchmark? It appears to be unused.

> +        def __init__(self):
> +            self.last_timestamp_ns =3D None
> +
> +        def catchall(self, *rec_args, event, timestamp_ns, pid, event_id=
):
> +            if self.last_timestamp_ns is None:
> +                self.last_timestamp_ns =3D timestamp_ns
> +            delta_ns =3D timestamp_ns - self.last_timestamp_ns
> +            self.last_timestamp_ns =3D timestamp_ns
> +
> +            fields =3D [
> +                f'{name}=3D{r}' if is_string(type) else f'{name}=3D0x{r:=
x}'
> +                for r, (type, name) in zip(rec_args, event.args)
> +            ]
> +            print(f'{event.name} {delta_ns / 1000:0.3f} {pid=3D} ' + ' '=
=2Ejoin(fields))
> +
>      try:
>          run(Formatter())
>      except SimpleException as e:
> --=20
> 2.38.1
>=20

--VDjLFN1ZXrU4TIHr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmULVgcACgkQnKSrs4Gr
c8gqcQgAsJzuWZoLPApwXUsrK0mYAfZTcy+H1FMwCOnNt8gVWISQQnyfe+LOCTW6
jV4cjVzVN6Hfhwc32uyN8ypRy/HmpefUqjNGC9/p+tHS9exbvCfrIw1VzQL2sCJ8
ZSDqiyyz0LiWjqZ1gUcwZg093eICmeLX5ZrNc4iq0Zcb9Qw4mVN6e4aM5APIJx0B
1eumZPxHHDlGGn1cdza27yVZMT96o0gUOEHKCLQ4p2VuR1ZSHwqKPIO1BxsXCfJc
RaKGdKwl+ckJPnHa+6oVPuvvyJmBZ+GUxVzAY8A+7le4PzrT6BUonXvTQw2CW0MT
b3/fhM5MbHf3qjR50RtWCDKp8uVeYQ==
=NLez
-----END PGP SIGNATURE-----

--VDjLFN1ZXrU4TIHr--


