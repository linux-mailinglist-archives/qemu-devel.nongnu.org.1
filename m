Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B02CD72CC17
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 19:10:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8l2K-0007Vi-DB; Mon, 12 Jun 2023 13:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ld.adecy@gmail.com>)
 id 1q8l2E-0007VN-VL; Mon, 12 Jun 2023 13:08:54 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ld.adecy@gmail.com>)
 id 1q8l2D-0004IL-Aj; Mon, 12 Jun 2023 13:08:54 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-45bcbd77636so1270449e0c.1; 
 Mon, 12 Jun 2023 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686589731; x=1689181731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f8RaT4tqEq0dgBg9lyOzwO0SMgFBnHC8F0PQOfagT2I=;
 b=IIz/8EU2ndW4gAEn08qTU1dqCcLXbSqNo1r9+y5iZacSb3IBUWEZfN7vvgTcKViegu
 MuORGWOZR2eZOyuU8HVvBlLS3QdIo9/rMDawpm45hjE5+UOtjrri4Xs8RGOWgHU++zv/
 umsv6nZ8Ht9hr+nV2g718Ek4nCdBycLv/WkEQMRXOc+FE2egIw4+jb4d3bQC0l2AqGW9
 hKNGgSJ4swaSibWcaU4TP1wNE+J1cDMrCJi2MtUD/t03KYl3ppKU2+ROY2+ipq0gttB0
 WvlM5U8vZ8uk5VF9bOHN2lOdkoJkEdO/pX0Uw8F+aXEIy1ntWK/C8PtR2M/duHUTluBI
 DOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686589731; x=1689181731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f8RaT4tqEq0dgBg9lyOzwO0SMgFBnHC8F0PQOfagT2I=;
 b=hYlUF2aWKwxvSfxzurEQSW81OppQoOUzo9zoJt4bKn1tZks53WKNqOdQaGQxPEBbqh
 y5eXie1pAM0LlNsSgxTfNmWHoJFvomRL2ld06tsxNSSQ6nZiFKoqIlHun9BL5msKIIYs
 JZTuqBkgXhF0zKljGzwOh7JK1UIzggMlXNDJE7ntxRcl6F4xJU5/eNbIrwVOOPCTIqsG
 kjoOLRfac/4Fk2YJgFHIOU4wTWd/DUqOrJiWdHmJ25vxwdC6FuBUEsll86AQ2Kx0fQI1
 Z1MK8KZUs9uWtPjHOj16s1qn2mLf1tK47yKXhF3uRBDVEUQ92MNEdGcQdFThEuTmPGRK
 xGfQ==
X-Gm-Message-State: AC+VfDyZ50Ck3uISR2/0Ar7Ikyg4WAqIF82WiM29O5HpiYmnqcaLg8+A
 EzT2dwC8HCrfAZviIS6CJeLASmrxbNybcSk4WMY=
X-Google-Smtp-Source: ACHHUZ6NGYtoZ3If7yZijjJWvLmbzzuAiHngKOMZZhdUFnSjmYakM1f/AXadldwkZ1bSE9i2y7mUVmwh7x7JmrhPaO8=
X-Received: by 2002:a67:f95a:0:b0:43b:1e61:2207 with SMTP id
 u26-20020a67f95a000000b0043b1e612207mr4007089vsq.21.1686589730892; Mon, 12
 Jun 2023 10:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAB295yB5cFSZpGE74EW5hDMSNGnZfw06UC5ydepUL0sdT96WGg@mail.gmail.com>
 <CAB295yAzhzPpKC7KtpKk6t6x4Dn7Bpam=Nwfx8z0wAkZRP-JSg@mail.gmail.com>
 <268c1ca3-409f-bc43-0e88-c32f1eae71f9@linaro.org>
In-Reply-To: <268c1ca3-409f-bc43-0e88-c32f1eae71f9@linaro.org>
From: Adecy <ld.adecy@gmail.com>
Date: Mon, 12 Jun 2023 19:08:40 +0200
Message-ID: <CAB295yBBgRcUdBsP+DDiZU_WZAihdn8LQE_BAyHC=QRonHS8Sw@mail.gmail.com>
Subject: Re: Fwd: QEMU AVR Patch - Correct handling of AVR interrupts
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, mrolnik@gmail.com, qemu-trivial@nongnu.org
Content-Type: multipart/mixed; boundary="000000000000cb0e0f05fdf1c533"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=ld.adecy@gmail.com; helo=mail-vk1-xa33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000cb0e0f05fdf1c533
Content-Type: multipart/alternative; boundary="000000000000cb0e0d05fdf1c531"

--000000000000cb0e0d05fdf1c531
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Phil,

I believe I have resolved the problem.

However, I didn't managed to make git send-email work yet. So please find
the patch attached.

Best regards,

Le lun. 12 juin 2023 =C3=A0 14:53, Philippe Mathieu-Daud=C3=A9 <philmd@lina=
ro.org> a
=C3=A9crit :

> Hi Lucas,
>
> On 8/6/23 23:03, Adecy wrote:
> > ---------- Forwarded message ---------
> > De : *Adecy* <ld.adecy@gmail.com <mailto:ld.adecy@gmail.com>>
> > Date: jeu. 1 juin 2023 =C3=A0 21:34
> > Subject: QEMU AVR Patch - Correct handling of AVR interrupts
> > To: <qemu-trivial@nongnu.org <mailto:qemu-trivial@nongnu.org>>
> >
> >
> > Hello,
> >
> > I would like to submit the attached patch.
>
> Unfortunately your patch doesn't apply cleanly:
>
> Applying: Fix handling of AVR interrupts above 33 by switching ctz32 to
> ctz64
> error: patch failed: target/avr/helper.c:45
> error: target/avr/helper.c: patch does not apply
> Patch failed at 0001 Fix handling of AVR interrupts above 33 by
> switching ctz32 to ctz64
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> You can find help on how to send your patch here:
>
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitting=
-your-patches
>
> Thanks,
>
> Phil.
>
>

--000000000000cb0e0d05fdf1c531
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Phil,<div><br></div><div>
I believe I have resolved the problem.

</div><div><br></div><div>However, I=C2=A0didn&#39;t managed to make=C2=A0<=
span style=3D"font-weight:bold;background-color:rgb(232,231,221);color:rgb(=
78,68,60);font-family:Courier,monospace;font-size:14px">git send-email=C2=
=A0</span>work yet. So please find the patch attached.</div><div><br></div>=
<div>Best regards,</div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">Le=C2=A0lun. 12 juin 2023 =C3=A0=C2=A014:53, Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linar=
o.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Hi Lucas,<br>
<br>
On 8/6/23 23:03, Adecy wrote:<br>
&gt; ---------- Forwarded message ---------<br>
&gt; De=C2=A0: *Adecy* &lt;<a href=3D"mailto:ld.adecy@gmail.com" target=3D"=
_blank">ld.adecy@gmail.com</a> &lt;mailto:<a href=3D"mailto:ld.adecy@gmail.=
com" target=3D"_blank">ld.adecy@gmail.com</a>&gt;&gt;<br>
&gt; Date: jeu. 1 juin 2023 =C3=A0=C2=A021:34<br>
&gt; Subject: QEMU AVR Patch - Correct handling of AVR interrupts<br>
&gt; To: &lt;<a href=3D"mailto:qemu-trivial@nongnu.org" target=3D"_blank">q=
emu-trivial@nongnu.org</a> &lt;mailto:<a href=3D"mailto:qemu-trivial@nongnu=
.org" target=3D"_blank">qemu-trivial@nongnu.org</a>&gt;&gt;<br>
&gt; <br>
&gt; <br>
&gt; Hello,<br>
&gt; <br>
&gt; I would like to submit the attached patch.<br>
<br>
Unfortunately your patch doesn&#39;t apply cleanly:<br>
<br>
Applying: Fix handling of AVR interrupts above 33 by switching ctz32 to <br=
>
ctz64<br>
error: patch failed: target/avr/helper.c:45<br>
error: target/avr/helper.c: patch does not apply<br>
Patch failed at 0001 Fix handling of AVR interrupts above 33 by <br>
switching ctz32 to ctz64<br>
hint: Use &#39;git am --show-current-patch=3Ddiff&#39; to see the failed pa=
tch<br>
When you have resolved this problem, run &quot;git am --continue&quot;.<br>
If you prefer to skip this patch, run &quot;git am --skip&quot; instead.<br=
>
To restore the original branch and stop patching, run &quot;git am --abort&=
quot;.<br>
<br>
You can find help on how to send your patch here:<br>
<a href=3D"https://www.qemu.org/docs/master/devel/submitting-a-patch.html#s=
ubmitting-your-patches" rel=3D"noreferrer" target=3D"_blank">https://www.qe=
mu.org/docs/master/devel/submitting-a-patch.html#submitting-your-patches</a=
><br>
<br>
Thanks,<br>
<br>
Phil.<br>
<br>
</blockquote></div>

--000000000000cb0e0d05fdf1c531--

--000000000000cb0e0f05fdf1c533
Content-Type: application/octet-stream; 
	name="0001-Fix-handling-of-AVR-interrupts-above-33.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-handling-of-AVR-interrupts-above-33.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lit1bq0v0>
X-Attachment-Id: f_lit1bq0v0

RnJvbSAzOWI3NTI1NjM1NTYwY2YzY2VhM2JkZWZkNTMyMjBjMTI3NGMyM2JiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogTHVjYXMgRGlldHJpY2ggPGxkLmFkZWN5QGdtYWlsLmNvbT4N
CkRhdGU6IE1vbiwgMTIgSnVuIDIwMjMgMTk6NDM6NTkgKzAyMDANClN1YmplY3Q6IFtQQVRDSF0g
Rml4IGhhbmRsaW5nIG9mIEFWUiBpbnRlcnJ1cHRzIGFib3ZlIDMzLg0KDQpUaGlzIGNvbW1pdCBh
ZGRyZXNzZXMgYSBidWcgaW4gdGhlIEFWUiBpbnRlcnJ1cHQgaGFuZGxpbmcgY29kZS4NClRoZSBt
b2RpZmljYXRpb24gaW52b2x2ZXMgcmVwbGFjaW5nIHRoZSB1c2FnZSBvZiB0aGUgY3R6MzIgZnVu
Y3Rpb24NCndpdGggY3R6NjQgdG8gZW5zdXJlIHByb3BlciBoYW5kbGluZyBvZiBpbnRlcnJ1cHRz
IGFib3ZlIDMzIGluIHRoZSBBVlINCnRhcmdldC4NCg0KUHJldmlvdXNseSwgdGltZXJzIDMsIDQs
IGFuZCA1IGludGVycnVwdHMgd2VyZSBub3QgZnVuY3Rpb25pbmcgY29ycmVjdGx5DQpiZWNhdXNl
IG1vc3Qgb2YgdGhlaXIgaW50ZXJydXB0IHZlY3RvcnMgYXJlIG51bWJlcmVkIGFib3ZlIDMzLg0K
DQpTaWduZWQtb2ZmLWJ5OiBMdWNhcyBEaWV0cmljaCA8bGQuYWRlY3lAZ21haWwuY29tPg0KLS0t
DQogY2Fwc3RvbmUgICAgICAgICAgICAgICAgICAgICAgfCAxICsNCiBkdGMgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8IDEgKw0KIG1lc29uICAgICAgICAgICAgICAgICAgICAgICAgIHwgMSAr
DQogcm9tcy9zZ2FiaW9zICAgICAgICAgICAgICAgICAgfCAxICsNCiBzbGlycCAgICAgICAgICAg
ICAgICAgICAgICAgICB8IDEgKw0KIHRhcmdldC9hdnIvaGVscGVyLmMgICAgICAgICAgIHwgNCAr
Ky0tDQogdGVzdHMvZnAvYmVya2VsZXktc29mdGZsb2F0LTMgfCAxICsNCiB0ZXN0cy9mcC9iZXJr
ZWxleS10ZXN0ZmxvYXQtMyB8IDEgKw0KIHVpL2tleWNvZGVtYXBkYiAgICAgICAgICAgICAgIHwg
MSArDQogOSBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
IGNyZWF0ZSBtb2RlIDE2MDAwMCBjYXBzdG9uZQ0KIGNyZWF0ZSBtb2RlIDE2MDAwMCBkdGMNCiBj
cmVhdGUgbW9kZSAxNjAwMDAgbWVzb24NCiBjcmVhdGUgbW9kZSAxNjAwMDAgcm9tcy9zZ2FiaW9z
DQogY3JlYXRlIG1vZGUgMTYwMDAwIHNsaXJwDQogY3JlYXRlIG1vZGUgMTYwMDAwIHRlc3RzL2Zw
L2JlcmtlbGV5LXNvZnRmbG9hdC0zDQogY3JlYXRlIG1vZGUgMTYwMDAwIHRlc3RzL2ZwL2Jlcmtl
bGV5LXRlc3RmbG9hdC0zDQogY3JlYXRlIG1vZGUgMTYwMDAwIHVpL2tleWNvZGVtYXBkYg0KDQpk
aWZmIC0tZ2l0IGEvY2Fwc3RvbmUgYi9jYXBzdG9uZQ0KbmV3IGZpbGUgbW9kZSAxNjAwMDANCmlu
ZGV4IDAwMDAwMDAwMDAuLmY4YjFiODMzMDENCi0tLSAvZGV2L251bGwNCisrKyBiL2NhcHN0b25l
DQpAQCAtMCwwICsxIEBADQorU3VicHJvamVjdCBjb21taXQgZjhiMWI4MzMwMTVhNGFlNDcxMTBl
ZDA2OGUwZGViNzEwNmNlZDY2ZA0KZGlmZiAtLWdpdCBhL2R0YyBiL2R0Yw0KbmV3IGZpbGUgbW9k
ZSAxNjAwMDANCmluZGV4IDAwMDAwMDAwMDAuLmI2OTEwYmVjMTENCi0tLSAvZGV2L251bGwNCisr
KyBiL2R0Yw0KQEAgLTAsMCArMSBAQA0KK1N1YnByb2plY3QgY29tbWl0IGI2OTEwYmVjMTE2MTQ5
ODBhMjFlNDZmYmNjYzM1OTM0YjY3MWJkODENCmRpZmYgLS1naXQgYS9tZXNvbiBiL21lc29uDQpu
ZXcgZmlsZSBtb2RlIDE2MDAwMA0KaW5kZXggMDAwMDAwMDAwMC4uMTJmOWYwNGJhMA0KLS0tIC9k
ZXYvbnVsbA0KKysrIGIvbWVzb24NCkBAIC0wLDAgKzEgQEANCitTdWJwcm9qZWN0IGNvbW1pdCAx
MmY5ZjA0YmEwZGVjZmRhNDI1ZGJiZjlhNTAxMDg0YzE1M2EyZDE4DQpkaWZmIC0tZ2l0IGEvcm9t
cy9zZ2FiaW9zIGIvcm9tcy9zZ2FiaW9zDQpuZXcgZmlsZSBtb2RlIDE2MDAwMA0KaW5kZXggMDAw
MDAwMDAwMC4uY2JhZWU1MjI4Nw0KLS0tIC9kZXYvbnVsbA0KKysrIGIvcm9tcy9zZ2FiaW9zDQpA
QCAtMCwwICsxIEBADQorU3VicHJvamVjdCBjb21taXQgY2JhZWU1MjI4N2U1ZjMyMzczMTgxY2Zm
NTBhMDBiNmM0YWM5MDE1YQ0KZGlmZiAtLWdpdCBhL3NsaXJwIGIvc2xpcnANCm5ldyBmaWxlIG1v
ZGUgMTYwMDAwDQppbmRleCAwMDAwMDAwMDAwLi5hODhkOWFjZTIzDQotLS0gL2Rldi9udWxsDQor
KysgYi9zbGlycA0KQEAgLTAsMCArMSBAQA0KK1N1YnByb2plY3QgY29tbWl0IGE4OGQ5YWNlMjM0
YTI0Y2UxYzE3MTg5NjQyZWY5MTA0Nzk5NDI1ZTANCmRpZmYgLS1naXQgYS90YXJnZXQvYXZyL2hl
bHBlci5jIGIvdGFyZ2V0L2F2ci9oZWxwZXIuYw0KaW5kZXggMmJhZDI0MmE2Ni4uZTZlN2Q1MTQ4
NyAxMDA2NDQNCi0tLSBhL3RhcmdldC9hdnIvaGVscGVyLmMNCisrKyBiL3RhcmdldC9hdnIvaGVs
cGVyLmMNCkBAIC01Miw3ICs1Miw3IEBAIGJvb2wgYXZyX2NwdV9leGVjX2ludGVycnVwdChDUFVT
dGF0ZSAqY3MsIGludCBpbnRlcnJ1cHRfcmVxdWVzdCkNCiAgICAgfQ0KICAgICBpZiAoaW50ZXJy
dXB0X3JlcXVlc3QgJiBDUFVfSU5URVJSVVBUX0hBUkQpIHsNCiAgICAgICAgIGlmIChjcHVfaW50
ZXJydXB0c19lbmFibGVkKGVudikgJiYgZW52LT5pbnRzcmMgIT0gMCkgew0KLSAgICAgICAgICAg
IGludCBpbmRleCA9IGN0ejMyKGVudi0+aW50c3JjKTsNCisgICAgICAgICAgICBpbnQgaW5kZXgg
PSBjdHo2NChlbnYtPmludHNyYyk7DQogICAgICAgICAgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9
IEVYQ1BfSU5UKGluZGV4KTsNCiAgICAgICAgICAgICBhdnJfY3B1X2RvX2ludGVycnVwdChjcyk7
DQogDQpAQCAtNzksNyArNzksNyBAQCB2b2lkIGF2cl9jcHVfZG9faW50ZXJydXB0KENQVVN0YXRl
ICpjcykNCiAgICAgaWYgKGNzLT5leGNlcHRpb25faW5kZXggPT0gRVhDUF9SRVNFVCkgew0KICAg
ICAgICAgdmVjdG9yID0gMDsNCiAgICAgfSBlbHNlIGlmIChlbnYtPmludHNyYyAhPSAwKSB7DQot
ICAgICAgICB2ZWN0b3IgPSBjdHozMihlbnYtPmludHNyYykgKyAxOw0KKyAgICAgICAgdmVjdG9y
ID0gY3R6NjQoZW52LT5pbnRzcmMpICsgMTsNCiAgICAgfQ0KIA0KICAgICBpZiAoYXZyX2ZlYXR1
cmUoZW52LCBBVlJfRkVBVFVSRV8zX0JZVEVfUEMpKSB7DQpkaWZmIC0tZ2l0IGEvdGVzdHMvZnAv
YmVya2VsZXktc29mdGZsb2F0LTMgYi90ZXN0cy9mcC9iZXJrZWxleS1zb2Z0ZmxvYXQtMw0KbmV3
IGZpbGUgbW9kZSAxNjAwMDANCmluZGV4IDAwMDAwMDAwMDAuLmI2NGFmNDFjMzINCi0tLSAvZGV2
L251bGwNCisrKyBiL3Rlc3RzL2ZwL2JlcmtlbGV5LXNvZnRmbG9hdC0zDQpAQCAtMCwwICsxIEBA
DQorU3VicHJvamVjdCBjb21taXQgYjY0YWY0MWMzMjc2Zjk3ZjBlMTgxOTIwNDAwZWUwNTZiOWM4
ODAzNw0KZGlmZiAtLWdpdCBhL3Rlc3RzL2ZwL2JlcmtlbGV5LXRlc3RmbG9hdC0zIGIvdGVzdHMv
ZnAvYmVya2VsZXktdGVzdGZsb2F0LTMNCm5ldyBmaWxlIG1vZGUgMTYwMDAwDQppbmRleCAwMDAw
MDAwMDAwLi41YTU5ZGNlYzE5DQotLS0gL2Rldi9udWxsDQorKysgYi90ZXN0cy9mcC9iZXJrZWxl
eS10ZXN0ZmxvYXQtMw0KQEAgLTAsMCArMSBAQA0KK1N1YnByb2plY3QgY29tbWl0IDVhNTlkY2Vj
MTkzMjczOTZhMDExYTE3ZmQ5MjRhZWQ0ZmVjNDE2YjMNCmRpZmYgLS1naXQgYS91aS9rZXljb2Rl
bWFwZGIgYi91aS9rZXljb2RlbWFwZGINCm5ldyBmaWxlIG1vZGUgMTYwMDAwDQppbmRleCAwMDAw
MDAwMDAwLi5kMjEwMDliMWM5DQotLS0gL2Rldi9udWxsDQorKysgYi91aS9rZXljb2RlbWFwZGIN
CkBAIC0wLDAgKzEgQEANCitTdWJwcm9qZWN0IGNvbW1pdCBkMjEwMDliMWM5Zjk0Yjc0MGVhNjZi
ZThlNDhhMWQ4YWQ4MTI0MDIzDQotLSANCjIuMzkuMQ0KDQo=
--000000000000cb0e0f05fdf1c533--

