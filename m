Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FC473A56A
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 17:55:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMe8-0002DU-DD; Thu, 22 Jun 2023 11:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qCMe6-0002DE-3O
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qCMe4-0000Bk-Al
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687449290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9uDZK2HgikjH2JGS+jcSQjkCRE4NEwOHQq9XRX/62MM=;
 b=TWhq6kV0XDeiMHqERianWs/tVM7ol2t58jLyPLMzgC3jlaZtIe52YVQzspoU7j9IbzCPWp
 Ke0mGWANd9OQgJk2yEJvTUa62CRAfwQ4jIqq2RfIKUZxKo2+QzLClErwRbOkS5H/uShMdr
 WZUswM5NzGCB+5N31Vrg6Z5RI8muFGY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-Mebq6bC4NiGXNZ98pE4tJw-1; Thu, 22 Jun 2023 11:54:46 -0400
X-MC-Unique: Mebq6bC4NiGXNZ98pE4tJw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f8283a3a7aso17703711cf.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 08:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687449285; x=1690041285;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9uDZK2HgikjH2JGS+jcSQjkCRE4NEwOHQq9XRX/62MM=;
 b=lwvYdPyTWmFueEYw7XZ5R5WlPxrIx4vdbrIgs0/9bEX8c9p69E+NOJODLUL5iElEVj
 rtE1bCMkiX1EkKW+QeKhrbsult76k46u1fRs+QE94k2DCT+AgJY+gB0VrY+3r0Z/82xH
 41ft9wIaWNlSdVrsaaXZI9G72OIayoGF5zRj8jRwig/iEPf4g9BOsPiwxj+xzfjs99YR
 KMHpOVDwpBUpKFPoCt3XTBSvPzOdkPjcLd29L10bPLvu8I8g+spHh6WEX4au2Z5FZxaX
 Cku5v4hGxiJW9nDebw2D/uhOnM0eMsDIbV3ixltBOYa9lkpeanzwP3ySnYh4mu4x1hv+
 /l3w==
X-Gm-Message-State: AC+VfDz3DPNrvriPXg2f009ZlbbifWzznPXe6RArKqSZ7I8CbPnXuTrR
 9AnptZlZlczXFG5w0plLueFwgWpxeV5ch60jBgYMXgPD6ocGnVPn+pAepwUnPOGu74Q+oeVmZ19
 tkfSOoqAK3KxcxLs=
X-Received: by 2002:a05:622a:1aa8:b0:3ff:2d2a:a4ec with SMTP id
 s40-20020a05622a1aa800b003ff2d2aa4ecmr10313238qtc.4.1687449285565; 
 Thu, 22 Jun 2023 08:54:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5TAOUQdsJv7BYPGIlgJiwn32ognwcjbvAgkf/R0/Ha6iA8wF5CRMyxKFp+WQN9oz8vBsnUpw==
X-Received: by 2002:a05:622a:1aa8:b0:3ff:2d2a:a4ec with SMTP id
 s40-20020a05622a1aa800b003ff2d2aa4ecmr10313214qtc.4.1687449285254; 
 Thu, 22 Jun 2023 08:54:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 g9-20020ac81249000000b003fe8a96fb3bsm1655309qtj.54.2023.06.22.08.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 08:54:44 -0700 (PDT)
Date: Thu, 22 Jun 2023 11:54:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Message-ID: <ZJRuw19Rc1LlPQId@x1n>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
 <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
 <87wmzv7ubn.fsf@secure.mitica> <ZJQbnmbFZkY51bSy@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJQbnmbFZkY51bSy@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 22, 2023 at 10:59:58AM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 22, 2023 at 10:52:12AM +0200, Juan Quintela wrote:
> > Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > On 6/12/23 22:51, Juan Quintela wrote:
> > >>> Shall we just leave it there?  Or is deprecating it helps us in any form?
> > >> See the patches two weeks ago when people complained that lisen(.., num)
> > >> was too low.  And there are other parameters that work the same way
> > >> (that I convenientely had forgotten).  So the easiest way to get things
> > >> right is to use "defer" always.  Using -incoming "uri" should only be
> > >> for people that "know what they are doing", so we had to ways to do it:
> > >> - review all migration options and see which ones work without defer
> > >>    and document it
> > >> - deprecate everything that is not defer.
> > >
> > > "-incoming <uri>" is literally the same as running "migrate-incoming"
> > > as the first thing on the monitor:
> > >
> > >     if (incoming) {
> > >         Error *local_err = NULL;
> > >         if (strcmp(incoming, "defer") != 0) {
> > >             qmp_migrate_incoming(incoming, &local_err);
> > >             if (local_err) {
> > >                 error_reportf_err(local_err, "-incoming %s: ", incoming);
> > >                 exit(1);
> > >             }
> > >         }
> > >     } else if (autostart) {
> > >         qmp_cont(NULL);
> > >     }
> > >
> > > It's the only piece of code which distinguishes "-incoming defer" from
> > > "-incoming <uri>".
> > >
> > > So I'm not sure what the problem would be with keeping it?
> > 
> > User friendliness.
> > 
> > First of all, I use it all the time.  And I know that it is useful for
> > developers.  I was the one asking peter to implement -global
> > migration.foo to be able to test multifd with it.
> > 
> > The problem is that if you use more than two channels with multifd, on
> > the incoming side, you need to do:
> > 
> > - migrate_set_parameter multifd-channels 16
> > - migrate_incoming <uri>
> > 
> > And people continue to do:
> > 
> > - qemu -incoming <uri>
> > - migrate_set_parameter multifd-channels 16 (on the command line)
> > 
> > And they complain that it fails, because we are calling listen with the
> > wrong value.
> 
> IMHO if we want to improve user friendliness then arguing about use
> of the CLI vs QMP for migration is completely missing the bigger
> picture IMHO.
> 
> I've mentioned several times before that the user should never need to
> set this multifd-channels parameter (nor many other parameters) on the
> destination in the first place.
> 
> The QEMU migration stream should be changed to add a full
> bi-directional handshake, with negotiation of most parameters.
> IOW, the src QEMU should be configured with 16 channels, and
> it should connect the primary control channel, and then directly
> tell the dest that it wants to use 16 multifd channels.
> 
> If we're expecting the user to pass this info across to the dest
> manually we've already spectacularly failed wrt user friendliness.

I can try to move the todo even higher.  Trying to list the initial goals
here:

- One extra phase of handshake between src/dst (maybe the time to boost
  QEMU_VM_FILE_VERSION) before anything else happens.

- Dest shouldn't need to apply any cap/param, it should get all from src.
  Dest still need to be setup with an URI and that should be all it needs.

- Src shouldn't need to worry on the binary version of dst anymore as long
  as dest qemu supports handshake, because src can fetch it from dest.

- Handshake can always fail gracefully if anything wrong happened, it
  normally should mean dest qemu is not compatible with src's setup (either
  machine, device, or migration configs) for whatever reason.  Src should
  be able to get a solid error from dest if so.

- Handshake protocol should always be self-bootstrap-able, it means when we
  change the handshake protocol it should always works with old binaries.

  - When src is newer it should be able to know what's missing on dest and
    skip the new bits.

  - When dst is newer it should all rely on src (which is older) and it
    should always understand src's language.

- All !main channels need to be established later than the handshake - if
  we're going to do this anyway we probably should do it altogether to make
  channels named, so each channel used in migration needs to have a common
  header.  Prepare to deprecate the old tricks of channel orderings.

Does it look reasonable?  Anything to add/remove?

Thanks,

-- 
Peter Xu


