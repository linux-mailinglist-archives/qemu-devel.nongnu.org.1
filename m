Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 373F97E704D
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:30:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r18ql-0005Yi-VC; Thu, 09 Nov 2023 12:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r18qf-0005YO-N8
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:29:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r18qY-0001RS-3Z
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699550972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ly+niwtC73uSoYJCWiMMZaRjnlnv1il4ALMmuKPcq/o=;
 b=fyoFKRZz/Uv7/fmb2GbMP1jlBTfj6raeP04uXtaiIzgDDRexkLg8VsJXeZL3Yuwn8JOgiI
 4Go5zz6Xt4K3bqGmJJpYTEIJ/Y/yKIoriYPYGOREb7vxjNbz40J124bzVRLDp419uK9jn5
 glAquWMn6841dZJ5HYNsZQCubudEIKc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-Cl6GF41gPIGoF6tiiuM4uQ-1; Thu, 09 Nov 2023 12:29:30 -0500
X-MC-Unique: Cl6GF41gPIGoF6tiiuM4uQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41b83b3fd18so13001591cf.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 09:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699550970; x=1700155770;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ly+niwtC73uSoYJCWiMMZaRjnlnv1il4ALMmuKPcq/o=;
 b=jzEVoQO0gDwaO4l+/7Jra/i5plmCQx/AI00uuPB3e3LwWHaQ4Km4nLWaCL4gpa+F02
 Li6MkruwfCqGMExZi2DcX+eOJ54smKG6iiFDu0BrKVhXBgLJGkV1qOok5WfNAEMnVoQl
 veixrgdPgit2sXaLFZXjy27+uS/qBCU+3Q9j7fTBm6DobkNm6VSVJSRQqserUss7YHbc
 k4shgFgNRfSm6JSNZKsDA8VeH88oqZhPoglS8FBGI2jgUs73X+wDeWXlS4a5iAT+JUjL
 sng/YJbiPvE/OHOsiR1id9mAVUoXivlO1R8leZVTmE2C3pZvEJLw+VXlFoI7XU29CYzD
 LiqA==
X-Gm-Message-State: AOJu0YwW2TTlinQUcZd5d6boh/+IQA9EAT1H1ORiAVsV7tJYhOqRVyB/
 EJXoLAxo70n72xYebZdN/Cnhb6RPfD9SQSWHsGP+gpT+SWg9qcoB5jwaDSuvRmNw8Qa5DcvV/Gh
 WHim/IX0ueCGrLyh1RfGM8iQKl+5AoPM=
X-Received: by 2002:ac8:7f45:0:b0:40c:58a1:cb40 with SMTP id
 g5-20020ac87f45000000b0040c58a1cb40mr6135617qtk.15.1699550970017; 
 Thu, 09 Nov 2023 09:29:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKKY13HowQnJTaOv3DjVGbWzGX0ChExTUG8h0rgVKJvuKGw3VRyoq5lsmEwOe3sZpeM78YWs2359xU/LHYJbo=
X-Received: by 2002:ac8:7f45:0:b0:40c:58a1:cb40 with SMTP id
 g5-20020ac87f45000000b0040c58a1cb40mr6135607qtk.15.1699550969815; Thu, 09 Nov
 2023 09:29:29 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Nov 2023 09:29:28 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-8-victortoso@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20231016152704.221611-8-victortoso@redhat.com>
Date: Thu, 9 Nov 2023 09:29:28 -0800
Message-ID: <CABJz62PFopBRaMBc8Smtse9DJEy+0Qii7DtiTZGQdks3dXOdUw@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] qapi: golang: Generate qapi's union types in Go
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
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Oct 16, 2023 at 05:27:00PM +0200, Victor Toso wrote:
> This patch handles QAPI union types and generates the equivalent data
> structures and methods in Go to handle it.
>
> The QAPI union type has two types of fields: The @base and the
> @Variants members. The @base fields can be considered common members
> for the union while only one field maximum is set for the @Variants.
>
> In the QAPI specification, it defines a @discriminator field, which is
> an Enum type. The purpose of the  @discriminator is to identify which
> @variant type is being used.
>
> For the @discriminator's enum that are not handled by the QAPI Union,
> we add in the Go struct a separate block as "Unbranched enum fields".
> The rationale for this extra block is to allow the user to pass that
> enum value under the discriminator, without extra payload.
>
> The union types implement the Marshaler and Unmarshaler interfaces to
> seamless decode from JSON objects to Golang structs and vice versa.
>
> qapi:
>  | { 'union': 'SetPasswordOptions',
>  |   'base': { 'protocol': 'DisplayProtocol',
>  |             'password': 'str',
>  |             '*connected': 'SetPasswordAction' },
>  |   'discriminator': 'protocol',
>  |   'data': { 'vnc': 'SetPasswordOptionsVnc' } }
>
> go:
>  | type SetPasswordOptions struct {
>  | 	Password  string             `json:"password"`
>  | 	Connected *SetPasswordAction `json:"connected,omitempty"`
>  | 	// Variants fields
>  | 	Vnc *SetPasswordOptionsVnc `json:"-"`
>  | 	// Unbranched enum fields
>  | 	Spice bool `json:"-"`
>  | }

Instead of using bool for these, can we denote a special type? For
example

  type Empty struct{}

We could then do

  u := SetPasswordOptions{
    Password: "...",
    Spice: &Empty{},
  }

The benefit I have in mind is that you'd be able to check which
variant field is set consistently:

  if u.Vnc != nil {
    ...
  }
  if u.Spice != nil {
    ...
  }

Additionally, this would allow client code that *looks* at the union
to keep working even if actual data is later added to the branch;
client code that *creates* the union would need to be updated, of
course, but that would be the case regardless.

-- 
Andrea Bolognani / Red Hat / Virtualization


