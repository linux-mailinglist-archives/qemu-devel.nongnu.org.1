Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBD3A07D0C
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Jan 2025 17:12:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVv7l-0004nN-CG; Thu, 09 Jan 2025 11:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+10359aeb926cd7703950+7809+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tVv7I-0004mo-Sb
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:10:42 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+10359aeb926cd7703950+7809+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tVv7D-0005q8-SW
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JwI9iJre6Eo9GufUhVNcv0pqhPWVf7sW4dGiZ2WxesU=; b=uYNibT2fR5gec/itvn1kh6Fn+l
 DBv60akTZ2cnKpP1B/QBqTS2rZXjhvLBh08egiEX+UiBMzS3GbApGC1BV2Aynwg7+eXi2TmvXpNvj
 5zlIShvc7h1a1fy2bFxyBUlqqGQg0Tqr8a+Y4z83VpxtiNq3Io4zGFMM9cVwjd7ydvKgTEqY7SHAO
 8J1VBFgtcgCTd4wYEqwqPxxL1/mI4/x2IJoLqOuxoS9mQlCFhENqXC0hlFCBY9Qocs7ltd64nnUDs
 8G1ppdXfvsv9SsZmialhGbiTUHRMAMriW8mKqISLkohvSyDlcRNQQiQ3DuxSQnb41t3RgBXSH3Zj8
 5o++UFHA==;
Received: from 54-240-197-239.amazon.com ([54.240.197.239]
 helo=edge-dns-1.e-iad53.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tVv79-00000006wqf-1lCm; Thu, 09 Jan 2025 16:10:31 +0000
Message-ID: <2500e645b68d4c098cbb51d64c969ef16ca64bb9.camel@infradead.org>
Subject: Re: [PULL 0/1] vmclock queue
From: David Woodhouse <dwmw2@infradead.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Hilber
 <quic_philber@quicinc.com>,  "Mohamed Abuelfotoh, Hazem"
 <abuehaze@amazon.com>, paul <paul@xen.org>
Date: Thu, 09 Jan 2025 16:10:30 +0000
In-Reply-To: <CAJSP0QWph_F6_4z1bb-gS7maACfHbNDOitmzj54asQkXC=71EA@mail.gmail.com>
References: <20250108111023.156073-1-dwmw2@infradead.org>
 <CAJSP0QUyq6RfYPPV2EXthMaLr82Z9htEohaP4f+P=MLUF=JCWg@mail.gmail.com>
 <de33977443334962bf85d1f7968d2609ac35d6a5.camel@infradead.org>
 <CAJSP0QXmJ2RdYuwHWPjMSXrTKzLAu-sa_eDFOsuJhG9ztr_LyQ@mail.gmail.com>
 <86a600a818cd063397730848957cb2be3be783ae.camel@infradead.org>
 <CAJSP0QWph_F6_4z1bb-gS7maACfHbNDOitmzj54asQkXC=71EA@mail.gmail.com>
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-DcGkaVmS5viHfIJCh5xf"
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+10359aeb926cd7703950+7809+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


--=-DcGkaVmS5viHfIJCh5xf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-01-09 at 11:03 -0500, Stefan Hajnoczi wrote:
> On Thu, 9 Jan 2025 at 09:14, David Woodhouse <dwmw2@infradead.org> wrote:
> >=20
> > On Thu, 2025-01-09 at 09:01 -0500, Stefan Hajnoczi wrote:
> > > On Thu, 9 Jan 2025 at 08:18, David Woodhouse <dwmw2@infradead.org> wr=
ote:
> > > >=20
> > > > On Thu, 2025-01-09 at 07:52 -0500, Stefan Hajnoczi wrote:
> > > > > On Wed, 8 Jan 2025 at 06:11, David Woodhouse <dwmw2@infradead.org=
>
> > > > > wrote:
> > > > >=20
> > > >=20
> > > > > 2. Send pull requests with a GPG-signed tag (git tag --sign) and
> > > > > ensure that the repo URL in the email is https:// (the tooling re=
jects
> > > > > unencrypted http:// and git:// repo URLs).
> > > >=20
> > > > You mean *or* rather than *and* in that sentence, right? Because if
> > > > it's GPG-signed, then I can send it to you over carrier pigeon and =
you
> > > > can validate it; the transport is irrelevant.
> > > >=20
> > > > If you really did mean 'and'... is this a new bug in the tooling? L=
ast
> > > > time I used Peter's make-pullreq script, it worked fine=C2=B9.
> > >=20
> > > You're right, both are not required together for security. I still as=
k
> > > for both because we historically had some submaintainers without GPG
> > > keys and didn't want them to use unencrypted git:// or http:// URLs.
> > > It's easier if everyone does both so I don't have to check whether
> > > we've followed the right process depending on their GPG key status. I
> > > think QEMU submaintainers have now fully transitioned to GPG keys, so
> > > we could probably drop the https:// requirement.
> > >=20
> > > If it's not too much trouble to use https:// then that would be easie=
st.
> >=20
> > I tried the 'Advanced Web Server Setup' from
> > https://git-scm.com/docs/gitweb=C2=A0 :
> >=20
> > =C2=A0 # make the front page an internal rewrite to the gitweb script
> > =C2=A0 RewriteRule ^/$=C2=A0 /cgi-bin/gitweb.cgi
> >=20
> > =C2=A0 # make access for "dumb clients" work
> > =C2=A0 RewriteRule ^/(.*\.git/(?!/?(HEAD|info|objects|refs)).*)?$ \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /cgi-bin/gitweb.cgi%{REQUEST_URI}=C2=A0 [L,PT]
> >=20
> > But it seemed to break the gitweb access for URLs of the form
> > https://git.infradead.org/users/dwmw2/qemu.git/shortlog/refs/heads/xenf=
v
> > so for the *moment* I have reverted that and filed it in the 'too much
> > trouble' bucket. I will take another look at some point though.
>=20
> That's fine, I'll update my script to accept git://.

Thanks. I did fight it a bit longer and managed to get it to export the
repository as 'dumb' https, where it just exposes the files. Which kind
of works, but apparently not for tags. And it seems that some things
are *both* in .git/packed_refs and .git/refs/ so even pulling from some
branches gave the wrong results.

I tried to get the git-http-request thing to coexist with gitweb, but I
really have exceeded the time budget for messing with Apache now! :)


--=-DcGkaVmS5viHfIJCh5xf
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEwOTE2MTAz
MFowLwYJKoZIhvcNAQkEMSIEIAhuWPZTKfU4VgVw1u0Jvsx/jchD/D+ZqdUPXnSMLxSeMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIARjmDx/Lw+Z7y
c9hRe1GG5U1kgis7RvpmRqeYu/WRdUk+UbbdRvEvdTAwn36UfdtRtu2OKJk1YHAhUauB+qmS3NVf
E0Jwg6EvqDd2Og0ot/M+ePvKSlSUn7j+QtRJqQccbiLvmecG6HqH15CWgZokvzCSc8kMwzS8/r7H
1rak3bFIsbg1EY10gU1NkFfCWtXKON9+smfTbggpAFZ0+ACA1RrGnUA/6rX4OFA/qi8plRkfknJP
S/W12PJz8Li8S++zicDWKK8u2NWpTabWHsRvPOoif5Um/FMxamzoXOJsvPn+4U79odXybaCwq5kg
oFC5Fc3jtxnFziFvTC+QWkH09haL5Y3P3zBV46SV+0bWyQ7VoXKu1yeTQfCNEg1Ptf2LCItHIoLq
9q3nmNLC3WW0fxi4a5Qx0RCgAlcpmNszcQbcjCjXQsbDW0aXfEATNSDfK5sCcWN6SBu4yMw38+88
WNR9Yj+7MU8BpUnWJCEiTZ14VgXdHSgSNG3BBCdqkTAAyuNlKW9hRvuO2P24xr+93bPlZbEPct/3
jDY0l9910fKk/tl9jy1kaTp869wpnn245JgC4IrLh9OX+Hffr8mOw/6dzPKSiIwpIzla/q4O9Yun
x2Ht2iwDlEU+x8d0k1Ymw+Ctj/AjSg/VDAE7IHu9m4wPJ3ZF1OdrYFEd6jvijsUAAAAAAAA=


--=-DcGkaVmS5viHfIJCh5xf--

