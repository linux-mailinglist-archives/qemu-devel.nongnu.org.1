Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB53826740
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 03:11:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMf67-0001D4-Rr; Sun, 07 Jan 2024 21:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rMf66-0001Cr-Il
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 21:10:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rMf64-0003DB-TB
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 21:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704679834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c7hw8Bh0f9hsZYXrNNez6LIXbaISUfpt2dVcY5h5XjA=;
 b=GVSjRurFewRDFsTwfTeFk9KEiIizQIqfZqRCrEQ57mU6cr8LcRKsSMLCsZExHckpHdtROZ
 nxK9ZVEIYCm0B3a96ea7UqW3zlBSMyRIpxm0xqJu9Th/jE6byc0uKh5v5+qw2EwFGyypxk
 JZW3TygbnCC6pRR5sxTNpa4i3cInuA8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-tzl_XDnIPlOmbKky12wFWA-1; Sun, 07 Jan 2024 21:10:33 -0500
X-MC-Unique: tzl_XDnIPlOmbKky12wFWA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-28bea0ff98cso314622a91.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 18:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704679832; x=1705284632;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7hw8Bh0f9hsZYXrNNez6LIXbaISUfpt2dVcY5h5XjA=;
 b=VM51EJSojbYBUvQjVyFpe/RxPdtaFSrCTl6pJwVfjIAyj3d0B0ylNwzj5VBNMwTdc3
 t1JtbhrTJfe0qmM2qF3LQEq7z4OfFJtbHeXLRifR0OhcIwqWEYvC7qnTIPzmJBOu2Uws
 c266d42CRy8VjdS/HVAUcmA/zvic2JeAZR9LkwBxuNKxdZxOwHLrxyx2qoTF8i0MbU3W
 Pzu+bjAIjLiuWiGZB3y4TsS7LjHTzqUNt7BIov4DEONCmtsn7AYLYn69Sr/MScAfLyZT
 3310N0VlWQV1AKC3hPANSEXqmrdv0rnWglOfkp2YpQn7aS1czToKWgqClPx3qJ0AtSry
 2Q/g==
X-Gm-Message-State: AOJu0Ywex75SGI8A3tPcfk3xau04xXnfy+5XaAMzHd8d8W9hDM2tOzb/
 KO6dCul9vdxoTQR0PkT9Iw5VRtx5T7sMfQTtKQhW9Ag3y5XxyI7C1eFrBKy8AjivxVKhUVmAUnM
 BNW9oB62KfGKkQ62SmBhh7Ts=
X-Received: by 2002:a17:90a:4bce:b0:28b:c60:8dd0 with SMTP id
 u14-20020a17090a4bce00b0028b0c608dd0mr4182194pjl.2.1704679832527; 
 Sun, 07 Jan 2024 18:10:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5B1jP589KsqR+sYDMnUPvc7h922GJNqgMiCDKoW5I7tUntnHT0UFvhjwaOSyJg+6EIZkVdQ==
X-Received: by 2002:a17:90a:4bce:b0:28b:c60:8dd0 with SMTP id
 u14-20020a17090a4bce00b0028b0c608dd0mr4182179pjl.2.1704679832180; 
 Sun, 07 Jan 2024 18:10:32 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 w9-20020a1709029a8900b001d491db286fsm4992840plp.282.2024.01.07.18.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 18:10:31 -0800 (PST)
Date: Mon, 8 Jan 2024 10:10:24 +0800
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PULL 00/26] Migration 20240104 patches
Message-ID: <ZZtZkE7w9Rvv8_7H@x1n>
References: <20240104043213.431566-1-peterx@redhat.com>
 <CAFEAcA8iim9vr19DxRDVabdESvcz+pAx91Ff6a7wQB-rrsCxqg@mail.gmail.com>
 <ZZqaGf6nt0wkZgbS@x1n>
 <CAJSP0QVA3USmat7EodQ7eBk+sf0FCT7oYBen_251ZMeeZHJ5dg@mail.gmail.com>
 <CAFEAcA9Wx4wcZj2MtBfb7u-y4wrbbjNhbLXA21pqmcrS+T8+hw@mail.gmail.com>
 <CAJSP0QX2bmZboYPyQ5AQz-q=n2N4sp=zzzDYvoie=vhiAYQ+7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QX2bmZboYPyQ5AQz-q=n2N4sp=zzzDYvoie=vhiAYQ+7A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, Jan 07, 2024 at 11:28:25AM -0500, Stefan Hajnoczi wrote:
> On Sun, 7 Jan 2024 at 10:23, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Sun, 7 Jan 2024 at 12:41, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > >
> > > On Sun, 7 Jan 2024 at 07:34, Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Fri, Jan 05, 2024 at 04:08:40PM +0000, Peter Maydell wrote:
> > > > > I notice that your gpg key doesn't seem to be signed by anybody
> > > > > else; you might look at whether it's easy to get it signed
> > > > > by somebody else (eg some of your redhat colleagues).
> > > >
> > > > Hmm, I think I have signed with at least Juan and Stefan.  Which is the key
> > > > server we normally use?  Maybe I missed some steps there?
> > >
> > > Yes, Peter's key is signed by me:
> > >
> > > $ gpg --list-signatures 3B5FCCCDF3ABD706
> > > pub   ed25519/0x3B5FCCCDF3ABD706 2023-10-03 [SC]
> > >       Key fingerprint = B918 4DC2 0CC4 57DA CF7D  D1A9 3B5F CCCD F3AB D706
> > > uid                   [  full  ] Peter Xu <xzpeter@gmail.com>
> > > sig 3        0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
> > > sig          0x9CA4ABB381AB73C8 2023-10-10  Stefan Hajnoczi
> > > <stefanha@redhat.com>
> > > uid                   [  full  ] Peter Xu <peterx@redhat.com>
> > > sig 3        0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
> > > sig          0x9CA4ABB381AB73C8 2023-10-10  Stefan Hajnoczi
> > > <stefanha@redhat.com>
> > > sub   cv25519/0xD5261EB1CB0C6E45 2023-10-03 [E]
> > > sig          0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
> > >
> > > I have pushed to the keyservers again in case I forget.
> >
> > Thanks. Which keyservers did you use? I think these days the
> > keyserver infrastructure is unfortunately fragmented; I
> > probably didn't try refreshing from the right keyserver.
> 
> I ran gpg --send-key again and it said hkps://keyserver.ubuntu.com.

Thanks Stefan.  Indeed I can only see Stefan's sig there on the key server:

https://keyserver.ubuntu.com/pks/lookup?search=3b5fcccdf3abd706&fingerprint=on&op=index

I am guessing Juan forgot to do a "gpg --send-keys 3B5FCCCDF3ABD706". I'll
also try to ask maybe one or two more people to exchange keys.  Maybe
that'll also help.

Thanks,

-- 
Peter Xu


