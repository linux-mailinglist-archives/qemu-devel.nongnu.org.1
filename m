Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A6878B119
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 14:54:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qabid-00064h-Fb; Mon, 28 Aug 2023 08:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elijah@elijahr.dev>)
 id 1qaTO9-00036s-Rp
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 23:58:06 -0400
Received: from mail-4323.proton.ch ([185.70.43.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elijah@elijahr.dev>)
 id 1qaTO6-0000di-39
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 23:58:05 -0400
Date: Mon, 28 Aug 2023 03:57:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elijahr.dev;
 s=protonmail; t=1693195076; x=1693454276;
 bh=5WAw7vc7bVtIXh8SSEFC+pwKbMR38nd1H83r2u2ce+Y=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=NnOgf89qowuWw+95wxL6SlWxrAQcPU+34Ayv/nkqZ3gw1jkn1b2honkUTvaXId+3L
 fg4FStJGxW+4a0pHvfXmkMZDpNmte9i/vWv1KgnnVOmo//5fbhOyipip67cn8WFlc7
 I4rYOu2MIQWOaljzcWYYyUopy29zpT5AOylkJg3HnNCEd7JJu/CxaYVXJ7HlRBVkTj
 mVhPNAeAYNUdwaLqnnPbUNPTLyuYyoyyq+AmiY4prPk273Z+bADpr3EXU2b7lgObEB
 YMu/VqGxbDFAZnMno5rhpgYKC3lnHSb4Jh8AP2e55X5GNncoYX/HcJX3Xg99apyeWH
 JCWF2K9V6w1pA==
To: qemu-devel@nongnu.org
From: Elijah R <elijah@elijahr.dev>
Cc: marcandre.lureau@redhat.com
Subject: Help with QEMU DBUS display
Message-ID: <61fa4ed6-e299-4b1c-a152-ace156059567@elijahr.dev>
Feedback-ID: 75483513:user:proton
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------93b2c7e499fd733b1533130ca1bfc455b2dbfb65a060e860f519af34c2e4edd2";
 charset=utf-8
Received-SPF: pass client-ip=185.70.43.23; envelope-from=elijah@elijahr.dev;
 helo=mail-4323.proton.ch
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 MIME_HTML_MOSTLY=0.1, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Aug 2023 08:51:42 -0400
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------93b2c7e499fd733b1533130ca1bfc455b2dbfb65a060e860f519af34c2e4edd2
Content-Type: multipart/mixed;
 boundary=133217e072559dd71344fc5e81af3c0a5e5e553f618215fbc96800232641
Message-ID: <61fa4ed6-e299-4b1c-a152-ace156059567@elijahr.dev>
Date: Sun, 27 Aug 2023 23:57:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
From: Elijah R <elijah@elijahr.dev>
Subject: Help with QEMU DBUS display

--133217e072559dd71344fc5e81af3c0a5e5e553f618215fbc96800232641
Content-Type: multipart/alternative;
 boundary="------------woCgTUtM07ICreHyQsxglV4B"

--------------woCgTUtM07ICreHyQsxglV4B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I'm currently attempting to use qemu's DBUS display from within a go 
application, using the godbus 
<https://pkg.go.dev/github.com/godbus/dbus/v5> library. However, I'm 
hitting some roadblocks, and this is probably because I'm a bit confused 
about how qemu's peer-to-peer dbus connection works, and it's not 
explained in the documentation.


I invoke QEMU with the following argument

-display dbus,p2p=yes

and then connect to QMP through a separate UNIX socket. From my 
understanding, I need to listen on the socket separately in the program, 
and then pass qemu the file descriptor over QMP and run add_client.

In the same program I listen to the socket, and start waiting for a 
connection. Then, on another thread, get a file descriptor for the 
socket by first dialing it. Here's my code for that

sock, err := net.Dial("unix", "/tmp/qemudbus.sock")
if err != nil {
	return err
}
uc, ok := sock.(*net.UnixConn)
if !ok {
	return fmt.Errorf("Could not cast 
Conn to UnixConn")
}
file, err := uc.File()

I then pass this file descriptor to QEMU using QMP (I'm using 
DigitalOcean's qmp library)

res, err := mon.RunWithFile([]byte(`{"execute": "getfd", "arguments": {"fdname": "dbusmon"}}`), file)

And add the dbus client:

res, err = mon.Run([]byte(`{"execute": "add_client", "arguments": {"protocol": "@dbus-display", "fdname": "dbusmon"}}`))

This seems to work fine, as I'm then (apparently) able to make a DBUS 
connection with that socket without any error.

However, when I then try to do anything with that connection (In this 
case I'm attempting to introspect /org/qemu/Display1/VM), the call hangs 
and never returns.

node, err := introspect.Call(session.Object("org.qemu.Display1.VM", "/org/qemu/Display1/VM"))

I'm not sure what's going wrong here, but I suspect I'm obtaining the 
file descriptor wrong (am I supposed to dial the socket?) or I'm doing 
things in the wrong order.

Thanks in advance for any help.



Regards,

Elijah R

--------------woCgTUtM07ICreHyQsxglV4B
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
  </head>
  <body>
    <p>Hi!</p>
    <p>I&#39;m currently attempting to use qemu&#39;s DBUS display from within a
      go application, using the <a moz-do-not-send="true" href="https://pkg.go.dev/github.com/godbus/dbus/v5">godbus</a>
      library. However, I&#39;m hitting some roadblocks, and this is
      probably because I&#39;m a bit confused about how qemu&#39;s peer-to-peer
      dbus connection works, and it&#39;s not explained in the
      documentation.</p>
    <p><br/>
    </p>
    <p>I invoke QEMU with the following argument</p>
    <pre>-display dbus,p2p=yes
</pre>
    <p>and then connect to QMP through a separate UNIX socket. From my
      understanding, I need to listen on the socket separately in the
      program, and then pass qemu the file descriptor over QMP and run
      add_client.<br/>
    </p>
    <p>In the same program I listen to the socket, and start waiting
 for
      a connection. Then, on another thread, get a file descriptor for
      the socket by first dialing it. Here&#39;s my code for that</p>
    <pre>sock, err := net.Dial(&#34;unix&#34;, &#34;/tmp/qemudbus.sock&#34;)
if err != nil {
	return err
}
uc, ok := sock.(*net.UnixConn)
if !ok {
	return fmt.Errorf(&#34;Could not cast Conn to UnixConn&#34;)
}
file, err := uc.File()
</pre>
    <p>I then pass this file descriptor to QEMU using QMP (I&#39;m using
      DigitalOcean&#39;s qmp library)</p>
    <pre>res, err := mon.RunWithFile([]byte(`{&#34;execute&#34;: &#34;getfd&#34;, &#34;arguments&#34;: {&#34;fdname&#34;: &#34;dbusmon&#34;}}`), file)
</pre>
    <p>And add the dbus client:</p>
    <pre>res, err = mon.Run([]byte(`{&#34;execute&#34;: &#34;add_client&#34;, &#34;arguments&#34;: {&#34;protocol&#34;: &#34;@dbus-display&#34;, &#34;fdname&#34;: &#34;dbusmon&#34;}}`))

</pre>
    <p>This seems to work fine, as I&#39;m then (apparently) able to make a
      DBUS connection with that so
cket without any error. <br/>
    </p>
    <p>However, when I then try to do anything with that connection (In
      this case I&#39;m attempting to introspect /org/qemu/Display1/VM), the
      call hangs and never returns.</p>
    <pre>node, err := introspect.Call(session.Object(&#34;org.qemu.Display1.VM&#34;, &#34;/org/qemu/Display1/VM&#34;))
</pre>
    <p>I&#39;m not sure what&#39;s going wrong here, but I suspect I&#39;m obtaining
      the file descriptor wrong (am I supposed to dial the socket?) or
      I&#39;m doing things in the wrong order.</p>
    <p>Thanks in advance for any help.</p>
    <p><br/>
    </p>
    <p>Regards,</p>
    <p>Elijah R<br/>
    </p>
  

</body></html>
--------------woCgTUtM07ICreHyQsxglV4B--

--133217e072559dd71344fc5e81af3c0a5e5e553f618215fbc96800232641
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


--133217e072559dd71344fc5e81af3c0a5e5e553f618215fbc96800232641
Content-Transfer-Encoding: base64
Content-Disposition: attachment; name="publickey - elijah@elijahr.dev -
 a0a86704.asc"; filename="publickey - elijah@elijahr.dev - a0a86704.asc"
Content-Type: application/pgp-keys; name="publickey - elijah@elijahr.dev -
 a0a86704.asc"; filename="publickey - elijah@elijahr.dev - a0a86704.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuNy4xCgp4ak1FWkdhbW5SWUpLd1lCQkFIYVJ3
OEJBUWRBekFWa1FrNjdGQmE0cXhmdUJuSzF3MEpLdkpCQjBWdWtvaVgxCk9yeUR0bWZOSjJWc2FX
cGhhRUJsYkdscVlXaHlMbVJsZGlBOFpXeHBhbUZvUUdWc2FXcGhhSEl1WkdWMlBzS00KQkJBV0Nn
QStCWUprWnFhZEJBc0pCd2dKa0Zwa1gxVGJiTjNQQXhVSUNnUVdBQUlCQWhrQkFwc0RBaDRCRmlF
RQpvS2huQk5tbVFQS2ZzTlpKV21SZlZOdHMzYzhBQUpPc0FRQ2UxNWdvMGF6ZUNtQUFjVWZ0YWRV
a1VjOFQ2aGRTCmdSSHVqd1hXNXRsTWFBRCtMRFRCNVE2UVY1bDJqeGU0eWxTSkh5OHJWbHovclBR
TUxtUzF5ejhWaUEzT09BUmsKWnFhZEVnb3JCZ0VFQVpkVkFRVUJBUWRBZjBUQjFVWEZMNG1tc01U
Qys2ZlNlY1VRdHIrbTVEbVZ6NlNXTDdiVgpmMGNEQVFnSHduZ0VHQllJQUNvRmdtUm1wcDBKa0Zw
a1gxVGJiTjNQQXBzTUZpRUVvS2huQk5tbVFQS2ZzTlpKCldtUmZWTnRzM2M4QUFMakxBUDkvN1hB
MHkyYmt3YlZSZms3Qm9yTHRVVEgzU3BUdUZ3M2hJRkZwYXEvS2lBRUEKN1FkVmlGeDJTNDVJeWtt
ZE1QeStnTFJOWUN3QXZBTHRTQk1nUEtDOElnST0KPU85UjEKLS0tLS1FTkQgUEdQIFBVQkxJQyBL
RVkgQkxPQ0stLS0tLQ==
--133217e072559dd71344fc5e81af3c0a5e5e553f618215fbc96800232641--

--------93b2c7e499fd733b1533130ca1bfc455b2dbfb65a060e860f519af34c2e4edd2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmTsGzQJkFpkX1TbbN3PFiEEoKhnBNmmQPKfsNZJWmRfVNts
3c8AAIYUAPwLqieYWsZp6msgWzuQ5EZN0T5QI/4QfgWuNIfq1Y3+1AD+JnVp
3iphoYNibxJFZkhFMLFYDoiRwpGQiLOwu/LygAo=
=rcF8
-----END PGP SIGNATURE-----


--------93b2c7e499fd733b1533130ca1bfc455b2dbfb65a060e860f519af34c2e4edd2--


