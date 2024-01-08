Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8BD826748
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 03:36:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMfTr-0006Yl-7C; Sun, 07 Jan 2024 21:35:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rMfTp-0006Xc-QW
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 21:35:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rMfTn-0005XA-CG
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 21:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704681304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bPZGyeSsXWwHhbBY+AD2Y/Q6d/d4qaje9TefwUs26SA=;
 b=R1A6sUMf7238DZZtFb5p/IJ+MGLJFNJST4Q2wdg2AogIm1rW1+GQ3IXwGBun8UDXKCCvd2
 1LlKp+L4qy/lRVQLNlfjZ2ZWwpvl7bICIfHQ16kxElgg+w5outiUASXqbgxA5RuEVCMHby
 j9xu48eqnavtKyP4iMJVLdVYYeZZz8U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60--FhZmKydP0akfYTq3H4AAA-1; Sun, 07 Jan 2024 21:35:03 -0500
X-MC-Unique: -FhZmKydP0akfYTq3H4AAA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-28cb02a6027so274393a91.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 18:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704681302; x=1705286102;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPZGyeSsXWwHhbBY+AD2Y/Q6d/d4qaje9TefwUs26SA=;
 b=crBmSSQJzWaQH7Nohlp7+tK7WviiTq+5yJPcFU2+AWl9RD2DdKqJWx78UKGZc+EBel
 KrExt/AALCPl0xL2QlPGxLoc5pMwjOZzZP6UoUnFA0tppQFn0ZOK69PhC2joDFvz/TSU
 JdP95Bnd9wAbMXzmiRgQQm2oE9ZZe15IdGuJjoP4YKJ8cFW03WoZKavQ6MabZcQu+eY6
 3JX8ghh9uow2XJfk2VZRCdcFWJ8L9qsg0VtkG3F17z6V0fdnOT3Kl/ILHqKmWbp2t1OB
 uzfDaiW9v1dOjgQCJs97V0deQORBcbqlGgpN/VqErOsKiA2TM49vee0AoDHG3wVe/NcX
 XS3g==
X-Gm-Message-State: AOJu0YzJpS6e0t8UkZz9hwwQTIs4Gt76kWZLo3nBfvPHbHTBPBt8Q6q7
 eaxwRZzcvyJUSK4XWBUk+UIDLZarOZbCQdnQ+iRg5D5u5S6/IBw/M0GHGn2R609aTAGz/HAoCki
 y8sdzdqk/O300MsgIGwiIWMw=
X-Received: by 2002:a17:90a:b78e:b0:28c:18b:3971 with SMTP id
 m14-20020a17090ab78e00b0028c018b3971mr4538198pjr.1.1704681301903; 
 Sun, 07 Jan 2024 18:35:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrOqagFEpnNWUcAoMWBltAnMjJ9gKIb/Ftf/+7hN2IYvhaWlgdHNN7AbN/tKrdmesb0ASa4A==
X-Received: by 2002:a17:90a:b78e:b0:28c:18b:3971 with SMTP id
 m14-20020a17090ab78e00b0028c018b3971mr4538176pjr.1.1704681301592; 
 Sun, 07 Jan 2024 18:35:01 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 pd18-20020a17090b1dd200b0028c954526dasm5245052pjb.9.2024.01.07.18.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 18:35:01 -0800 (PST)
Date: Mon, 8 Jan 2024 10:34:53 +0800
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PULL 00/26] Migration 20240104 patches
Message-ID: <ZZtfTX-sTBR3aXti@x1n>
References: <20240104043213.431566-1-peterx@redhat.com>
 <CAFEAcA8iim9vr19DxRDVabdESvcz+pAx91Ff6a7wQB-rrsCxqg@mail.gmail.com>
 <ZZqaGf6nt0wkZgbS@x1n>
 <CAJSP0QVA3USmat7EodQ7eBk+sf0FCT7oYBen_251ZMeeZHJ5dg@mail.gmail.com>
 <CAFEAcA9Wx4wcZj2MtBfb7u-y4wrbbjNhbLXA21pqmcrS+T8+hw@mail.gmail.com>
 <CAJSP0QX2bmZboYPyQ5AQz-q=n2N4sp=zzzDYvoie=vhiAYQ+7A@mail.gmail.com>
 <ZZtZkE7w9Rvv8_7H@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZtZkE7w9Rvv8_7H@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jan 08, 2024 at 10:10:24AM +0800, Peter Xu wrote:
> On Sun, Jan 07, 2024 at 11:28:25AM -0500, Stefan Hajnoczi wrote:
> > On Sun, 7 Jan 2024 at 10:23, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Sun, 7 Jan 2024 at 12:41, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > > >
> > > > On Sun, 7 Jan 2024 at 07:34, Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > On Fri, Jan 05, 2024 at 04:08:40PM +0000, Peter Maydell wrote:
> > > > > > I notice that your gpg key doesn't seem to be signed by anybody
> > > > > > else; you might look at whether it's easy to get it signed
> > > > > > by somebody else (eg some of your redhat colleagues).
> > > > >
> > > > > Hmm, I think I have signed with at least Juan and Stefan.  Which is the key
> > > > > server we normally use?  Maybe I missed some steps there?
> > > >
> > > > Yes, Peter's key is signed by me:
> > > >
> > > > $ gpg --list-signatures 3B5FCCCDF3ABD706
> > > > pub   ed25519/0x3B5FCCCDF3ABD706 2023-10-03 [SC]
> > > >       Key fingerprint = B918 4DC2 0CC4 57DA CF7D  D1A9 3B5F CCCD F3AB D706
> > > > uid                   [  full  ] Peter Xu <xzpeter@gmail.com>
> > > > sig 3        0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
> > > > sig          0x9CA4ABB381AB73C8 2023-10-10  Stefan Hajnoczi
> > > > <stefanha@redhat.com>
> > > > uid                   [  full  ] Peter Xu <peterx@redhat.com>
> > > > sig 3        0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
> > > > sig          0x9CA4ABB381AB73C8 2023-10-10  Stefan Hajnoczi
> > > > <stefanha@redhat.com>
> > > > sub   cv25519/0xD5261EB1CB0C6E45 2023-10-03 [E]
> > > > sig          0x3B5FCCCDF3ABD706 2023-10-03  [self-signature]
> > > >
> > > > I have pushed to the keyservers again in case I forget.
> > >
> > > Thanks. Which keyservers did you use? I think these days the
> > > keyserver infrastructure is unfortunately fragmented; I
> > > probably didn't try refreshing from the right keyserver.
> > 
> > I ran gpg --send-key again and it said hkps://keyserver.ubuntu.com.
> 
> Thanks Stefan.  Indeed I can only see Stefan's sig there on the key server:
> 
> https://keyserver.ubuntu.com/pks/lookup?search=3b5fcccdf3abd706&fingerprint=on&op=index
> 
> I am guessing Juan forgot to do a "gpg --send-keys 3B5FCCCDF3ABD706". I'll
> also try to ask maybe one or two more people to exchange keys.  Maybe
> that'll also help.

Besides that, just now I also tried to do a remote --recv-keys on my own
key and I found that indeed the signature from Stefan was not attached.

Then I found this:

https://daniel-lange.com/archives/178-Getting-gpg-to-import-signatures-again.html

So it seems the default behavior of gpg command changed recently that it'll
stop to receive signatures besides the self signature to avoid DoS to the
keyservers.

https://dev.gnupg.org/rG23c978640812d123eaffd4108744bdfcf48f7c93

In short, now we seem to need:

  $ gpg --recv-keys --keyserver-option no-self-sigs-only $KEY_ID

To recover the old behavior to receive signs from others.

Thanks,

-- 
Peter Xu


