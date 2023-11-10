Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 050B17E7B19
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:52:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1OBP-0002RR-JN; Fri, 10 Nov 2023 04:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r1OBN-0002Py-Og
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:52:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r1OBM-0001BK-6f
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699609927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qyOQ8OyUvbpQnMbXfbMnBS4wiUhaCiIeeLHWIwSLSDk=;
 b=b6oCAdSYtR3dDNRCB+I4/KtspIO/V583kAMJi0wovNEfSxdEFk3azBkbQlj94WAvflfViV
 EawO0Ii083elS4EjKnTVfTXPBb6gKSBHbr/N/tvokslNFnJSJ9LErqmnsBSUP0ZsWiqHRK
 3/dXvhvjLOHHSznByHwXLez/3U01f/U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-THgY9AhBN0qfqN9NliUzew-1; Fri, 10 Nov 2023 04:52:04 -0500
X-MC-Unique: THgY9AhBN0qfqN9NliUzew-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-41e1d05a5d7so22330851cf.2
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 01:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699609922; x=1700214722;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qyOQ8OyUvbpQnMbXfbMnBS4wiUhaCiIeeLHWIwSLSDk=;
 b=ezDw5n2k4WJYETVQhfCz6htPKSylSM5tyi2cCgkfJ6q11xK3LGMNlSyBdF6UwsrDPa
 tqocwEnKyaaA+uMPlorR2Dt3c/Zj21BGLCoMcuUpdLxakksuE+r/twxxJXa0yQwZtVnb
 IuUyol80dXPB6m6D/ZG4KDUOuU8QQPBRghHSrNo3ZtGjkJeGd7ILerI76VU9WdTtWA8+
 k021Ub92o0bfQ+qjioLqgGQIR/CNbrsGA0dX44Xh7SOu8ViSBVtjLZXuKkRu62zXFvTI
 xNg60/njPJqCpgUjXIzQDjdBl88eLzoKrJj6lmipl++3UIrJzqoRiH62kV2o951Eq7/y
 mqrQ==
X-Gm-Message-State: AOJu0YwoFy5R0m9m4LN5SWcXnPtH2wMNV/UChcIVMu/sbMwbUqfvd7oV
 ee3eQwubLbe+1M+WIe6svIumDRDlQL58Il7bx45jIjcpIjxszIdtjOR1NUgf8i8ZE4LPyp/if/K
 lEpcUf3XQHtoxxsuZ2WOLX8lSJAfgVGTWeOl1XL8=
X-Received: by 2002:a05:622a:1906:b0:41e:1c47:50c4 with SMTP id
 w6-20020a05622a190600b0041e1c4750c4mr8180358qtc.60.1699609922320; 
 Fri, 10 Nov 2023 01:52:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/hM/01Vy6ezwjH6yAEBCEEQfm1T1jD4KGDJWTPCPJ1g1eYnFW86USJx0taY2A/QamEIhHW5xtTeMqENnwjFo=
X-Received: by 2002:a05:622a:1906:b0:41e:1c47:50c4 with SMTP id
 w6-20020a05622a190600b0041e1c4750c4mr8180344qtc.60.1699609922032; Fri, 10 Nov
 2023 01:52:02 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Nov 2023 01:52:01 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-9-victortoso@redhat.com>
 <CABJz62PJHOY8CLNe-xOrDqRupWMxVCz08WvaxY7tfg8e2WwOpg@mail.gmail.com>
 <72qoq2br3qqf5fn3e2lwbwy4eqeffckpyweqdk7oxpmn6ad43t@fabzivfwkesw>
MIME-Version: 1.0
In-Reply-To: <72qoq2br3qqf5fn3e2lwbwy4eqeffckpyweqdk7oxpmn6ad43t@fabzivfwkesw>
Date: Fri, 10 Nov 2023 01:52:01 -0800
Message-ID: <CABJz62OEyrPOr9tyYyLhKfVYS9hWy5aYYnLKy_uXj+_fWBY6zA@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] qapi: golang: Generate qapi's event types in Go
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Nov 09, 2023 at 08:13:38PM +0100, Victor Toso wrote:
> On Thu, Nov 09, 2023 at 09:59:50AM -0800, Andrea Bolognani wrote:
> > Now, I'm not sure I would go as far as suggesting that the
> > GetName() function should be completely removed, but maybe we
> > can try leaving it out from the initial version and see if
> > people start screaming?
>
> It might be useful for debugging too. I would rather log
> e.GetName() than the string version of the type but if that's the
> only reason we needed, I agree on removing for now.

I think the upside is too small considering the potential for abuse.

> > API-wise, I'm not a fan of the fact that we're forcing users to call
> > (Un)MarshalEvent instead of the standard (Un)MarshalJSON. If we add
> > something like
> >
> >   func GetEventType(data []byte) (Event, error) {
> >
> > it becomes feasible to stick with standard functions. We can of
> > course keep the (Un)MarshalEvent functions around for convenience,
> > but I don't think they should be the only available API.
>
> I agree. I'll change it. Perhaps we shouldn't use
> (Un)MarshalEvent at this layer at all. Probably the same for
> (Un)MarshalCommand.

Yeah, what I wrote for events applies 1:1 to commands as well.

Up to you whether or not you want to keep around the convenience
functions. It might indeed be fine to drop them for now and consider
reintroducing them later if it turns out that it really helps making
client code less clunky.

-- 
Andrea Bolognani / Red Hat / Virtualization


