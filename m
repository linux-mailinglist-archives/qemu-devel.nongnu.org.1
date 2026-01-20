Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
Delivered-To: lists+qemu-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iImLK1/Kb2mgMQAAu9opvQ
	(envelope-from <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>)
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:33:03 +0100
X-Original-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E749828
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:33:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGWr-00029j-1a; Tue, 20 Jan 2026 13:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1viGWp-00028r-6M
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:32:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1viGWm-0004xA-FR
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768933950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eUkuueK+X4u/bLVwIf6J4p0M7t0768LvdacUDNxPknk=;
 b=UPqrKHN0R2QMEHvzwEKbfMixqK7OlKMOTq7KWFQhN4QOOJYWWYUNJseXg9jHtEhCtK4uTl
 S3Ui69JXQB/i80dbWiOo2f7jR4uxex3tcNcPj7/t9kz1rxzuHO0ucqhew7FxZEGCRg41/U
 QcKxucANlhZEa5mWI22v36l/sH2nZ6g=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-2suJxFEbMGSe9Gizt3P42g-1; Tue, 20 Jan 2026 13:32:29 -0500
X-MC-Unique: 2suJxFEbMGSe9Gizt3P42g-1
X-Mimecast-MFC-AGG-ID: 2suJxFEbMGSe9Gizt3P42g_1768933949
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-78d694a1eb2so56525937b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:32:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768933949; cv=none;
 d=google.com; s=arc-20240605;
 b=Fitn6J3asigvD/G4sW6dWz3Q+RyLpxAJ8lFzQTLfNXItRlOS4RY+80xLF1t5Xu8SGk
 r2tB734KgWiWtQf0g9AXMh4jtudFRS460FsUA/4SK8XM22Jx446cSxi2/4YO67W0twMm
 bz8ToxaoYt92T75fIr+Mku5GwU4pi0nawUss1kSERXDk2etX0D3CCgXOReLYnP+GxPcz
 WN995TlBNC9fYsn/r6cTPKyPkuCKndNjDSo7eoXPOyKLy6b2dvyXL/+jpJUMfZdCePdN
 Y2/QjI9J4QcsBdl2eS6E/Zn3oH41svN3WqH/R0yjE7f2xwgPQp4CQHIaVnIhrmgcjm/o
 KkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eUkuueK+X4u/bLVwIf6J4p0M7t0768LvdacUDNxPknk=;
 fh=jm6QaAGnV17+u5Ubx2P/5VVq19DYDRw7hX2tO+OpmpA=;
 b=NwEoymfqYTgul3N/2I1hGEX4LNLepFa4ueInYKs+rRVw/3nwlKrUPvsY23jPMmgTpI
 5FzlYeETmX2zNz3NESGkvADXKAe9smCAzKVNXIkeUnfE/ilna8eBiGjDGLKpcLuE1gdC
 8eqmL5uOXBtMkF1W+hiJgBMNGSpa/so9Msrdl20OhPvZ/+i6NjT0YZ6+SpSX0MsuJvBx
 rtxSCKm/hJijfB6eyH185HzJc3GY4IrEBBIpAza3qDYwqRpmtKCLzAVaHVmiusjecDj4
 nOXCripbd9hFo1SoohVkOBRfJx+9r5Ml5b5VlE2JYIsJJ+4gYP4NfHMI/lZIpRRt5Hr6
 gceQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768933949; x=1769538749; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUkuueK+X4u/bLVwIf6J4p0M7t0768LvdacUDNxPknk=;
 b=Ma/o7hr8Ni5Tckv/AEhvCzwACl3pk2HT7VRKxUXi2SS5/pCQPJfn1wvmCHr1UixcTQ
 Z/3Pc+vKCeHJEWVguT0Yeo8JWuy4KD/Pjq8cxPJhy2t883UfepuszL2aGDsjrZSbUlge
 0Rm+89nBDpZH6qSdBIKJ6E/AohDfzgPpyloyyHv0KP48jtizJd5GMn811x53U0xXAs4y
 v4EypjZTb//0OjYdo5CA5Yxz7yZatg5i5vZWKNp078IWI1mRh8DTkQ3y4nTI09MwWfS0
 tK6B/Nfo/zOs6pWPefV5rnD6bYfhRmp8npzMlOC9p81Qdj53Z2d+nbR2HIOxZY6NBqLV
 M7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768933949; x=1769538749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eUkuueK+X4u/bLVwIf6J4p0M7t0768LvdacUDNxPknk=;
 b=dnbIrOUIOvrVgVMcKgJ8r61e73JyE6n4eCQlNg3xnPzlOkI98O4Zlt7gcAFMV953dJ
 vbzjBexzKsWWmlrq4bnJieCvcIQUto8r54Rmw8TXj3yoNVxp7hu70ZXCeAYMQbMTJwF/
 eR9ZtMjcbjwkmraaUiI0/PswJflu1dkAR1btRjtLnGCDNSEyDdMYTNTo+nf8SR4jc/48
 6BsWioyn9C8wnW7w/74MkGsAvylh9bpfy77wAiETJFLMaFYl6ZYClWdRnSc0AZLkt7fh
 1l6Xb2YD6hC7QvaNCU/qshEzfhLNlJ4FHKYna7UMkUOx3qy9kUqtqhbrIyoPN2lI+ay9
 2lXQ==
X-Gm-Message-State: AOJu0YwAlVDNrP1W95VkD3dUw7qDuOH49PGRPOROQNkW+tSg4VYvoBa2
 i11bMke8Kxk0ez+yKvdYrvp/U+D1yuLGe/e7kiaiyWmP15rERHoXShb1ngUAY9j7RplHiQg96kd
 Wu4bQmc+B1uzBZgshL2QUorKhexmR6NaEEBXPZ2U2KubY/+bUNINqUhsT5Bn1YScsQ6HB5zE8jy
 gYoy8Nb7NQkyyE64S5ne5yGNYL18VGP48=
X-Gm-Gg: AZuq6aJ6PM8yAakHufOIN2ztDyTlCH5OGbN5Ez+mrWBCn0avkmp3djU8Hmj0QoUeQW8
 w5pXqN0XrrXOw78QjAwhBvqE8j2ZxbS9Gk+6TzRfjxHkpaFStj7MgEgWwjoQVoOJF29Ya4/lWXI
 /weaCkam6hIaYyHLwSE9qNp+jes/wT7DGDRbKTcPG+vgylIbNBfGYJFalXdvZU2L6I8D6HuTKe3
 AhMfaWFjRFjMzflWPfz3DZOLw==
X-Received: by 2002:a05:690c:4b11:b0:787:cddb:ec2d with SMTP id
 00721157ae682-7940a12058amr53347757b3.19.1768933948465; 
 Tue, 20 Jan 2026 10:32:28 -0800 (PST)
X-Received: by 2002:a05:690c:4b11:b0:787:cddb:ec2d with SMTP id
 00721157ae682-7940a12058amr53347187b3.19.1768933948086; Tue, 20 Jan 2026
 10:32:28 -0800 (PST)
MIME-Version: 1.0
References: <20260115164756.799402-1-berrange@redhat.com>
 <20260115164756.799402-2-berrange@redhat.com>
In-Reply-To: <20260115164756.799402-2-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 20 Jan 2026 13:32:17 -0500
X-Gm-Features: AZwV_Qhv-Q2-HVry6B_cgIeObu3t_O8NvP_cWe_o0RZ_LlXn8saYJS4MbXTEgkc
Message-ID: <CAFn=p-as=ip=rdWLxdCPiXagvzMxKbZdze4qnjcQhTTNG7-+4A@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] Revert "python/aqmp: fix send_fd_scm for python
 3.6.x"
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
X-Spamd-Result: default: False [-2.21 / 15.00];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.51.188.0/24:c];
	MAILLIST(-0.20)[mailman];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[lists,qemu-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[jsnow@redhat.com,qemu-devel-bounces@nongnu.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:berrange@redhat.com,m:qemu-devel@nongnu.org,m:thuth@redhat.com,m:hreitz@redhat.com,m:qemu-block@nongnu.org,m:pbonzini@redhat.com,m:philmd@linaro.org,m:crosa@redhat.com,m:alex.bennee@linaro.org,m:kwolf@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[qemu-devel@nongnu.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jsnow@redhat.com,qemu-devel-bounces@nongnu.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:22989, ipnet:209.51.188.0/24, country:US];
	TAGGED_RCPT(0.00)[qemu-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.gnu.org:rdns,lists.gnu.org:helo,mail.gmail.com:mid,sock.family:url]
X-Rspamd-Queue-Id: 3F8E749828
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Jan 15, 2026 at 11:48=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> This reverts commit a57cb3e23d5ac918a69d0aab918470ff0b429ff9.
>
> The current code now only requires compatibility with Python
> 3.8 or later.
>
> The conditional usage of 'sendmsg' on the async IO socket
> wrapper will generate a deprecation warning on stderr
> every time send_fd_scm is used with older Python versions.
>
> This has the effect of breaking the QEMU I/O tests when run
> on Python versions before the 'sendmsg' wrapper was removed.
>
> Unconditionally accessing 'sock._sock' ensures we never use
> the asyncio socket wrapper, and thus never risk triggering
> deprecation warnings on any Python version
>
> Most notably this fixes the QEMU block I/O tests on CentOS
> Stream9 that use "sendmsg" for FD passing, which otherwise
> generate deprecation messages breaking the expected output
> comparison.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Acked-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  python/qemu/qmp/qmp_client.py | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/python/qemu/qmp/qmp_client.py b/python/qemu/qmp/qmp_client.p=
y
> index 8beccfe29d..7a115b693b 100644
> --- a/python/qemu/qmp/qmp_client.py
> +++ b/python/qemu/qmp/qmp_client.py
> @@ -720,12 +720,9 @@ def send_fd_scm(self, fd: int) -> None:
>          if sock.family !=3D socket.AF_UNIX:
>              raise QMPError("Sending file descriptors requires a UNIX soc=
ket.")
>
> -        if not hasattr(sock, 'sendmsg'):
> -            # We need to void the warranty sticker.
> -            # Access to sendmsg is scheduled for removal in Python 3.11.
> -            # Find the real backing socket to use it anyway.
> -            sock =3D sock._sock  # pylint: disable=3Dprotected-access
> -
> +        # Void the warranty sticker.
> +        # Access to sendmsg in asyncio is scheduled for removal in Pytho=
n 3.11.
> +        sock =3D sock._sock  # pylint: disable=3Dprotected-access
>          sock.sendmsg(
>              [b' '],
>              [(socket.SOL_SOCKET, socket.SCM_RIGHTS, struct.pack('@i', fd=
))]
> --
> 2.52.0
>

Acked-by: John Snow <jsnow@redhat.com>

PS, for your other qemu.qmp fix, it can go in as soon as the pipeline
is fixed, which I (think) I have accomplished here:
https://gitlab.com/qemu-project/python-qemu-qmp/-/merge_requests/47

Sorry for the delay on that.

--js


