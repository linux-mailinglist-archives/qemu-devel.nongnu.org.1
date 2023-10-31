Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B047DD09A
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:34:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqkW-0006af-O9; Tue, 31 Oct 2023 11:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxqkV-0006aW-Aj
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxqkT-0002WO-Iq
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698766412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8fc08W56wClcev0nZ53BYcD7B6+gun/WoeQFe6FmXkE=;
 b=DcWxxEVkRv9gb14HViGpKUESghOSFAGRvDqaiaNqiLf8sgqM+FE4qwX324sHYLIQs83ZKT
 JOAL02FRplSdmUOflodFwVzTaxgus2svFGLUd7iSxfCLBaElQXNEeHRI1RbQhSp2xr+BUw
 P2nseJHIyJZRTpXRnroTYARW1nHYedk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-IPDJexRSPX-wSLLBuS9aSw-1; Tue, 31 Oct 2023 11:33:29 -0400
X-MC-Unique: IPDJexRSPX-wSLLBuS9aSw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66ffa15d354so12357506d6.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698766381; x=1699371181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fc08W56wClcev0nZ53BYcD7B6+gun/WoeQFe6FmXkE=;
 b=US/70NWFixVQfDi0ZwYNjKuJmjvaPtt+lyzbPab8W1qSOBrpm2wTBFUnVP+p8ppB7x
 XOUNyASBFNRNbtHROAlESYHKZURyINcqtp7HQIDrSbDzhvD1CwONhEOj04cmyeqmpO4k
 Tf7Oo6sqinf+DxKCIGDee8WDq2vPeQxtwz73Gna9jkiXKXdSw3BIwyqws4q6vk+SZdEF
 /DL9xnFnvmoFY4LHv2V7aA9L6f4jmC6Bx8ixLZ4dlgxiEbOXCa+2g1Hn+nIpFondolbD
 by6BFg+c+0nXIr398v0haRjd4CHtJkmLWua2EPPH9s5dDnQ9tFHt+eO8YsV8+zNWD11T
 VVWw==
X-Gm-Message-State: AOJu0YzZMzcxT41UFWUJ6cDOajM8uBqIZtrk0UUcBSVL1+33MoRbALBM
 sujMuhaqpc3RsfR3P+IFW0D0RTrSQwsuDPM0k1Q0kDw+Lcw7CT980LNHWpreuY2zAOE934dUsy8
 1fNY4SneMWJFk+/I=
X-Received: by 2002:a05:6214:398f:b0:66d:264c:450f with SMTP id
 ny15-20020a056214398f00b0066d264c450fmr13606227qvb.0.1698766380740; 
 Tue, 31 Oct 2023 08:33:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxERGfA/PPrCoSU5SBYXCdKLsPH/sP4R+whcepvMC4/6nGv5wYUxBJVfCg4eU6ilKpdTqlyA==
X-Received: by 2002:a05:6214:398f:b0:66d:264c:450f with SMTP id
 ny15-20020a056214398f00b0066d264c450fmr13606205qvb.0.1698766380401; 
 Tue, 31 Oct 2023 08:33:00 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 l3-20020ad44443000000b00674a45499dcsm615485qvt.88.2023.10.31.08.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 08:32:59 -0700 (PDT)
Date: Tue, 31 Oct 2023 11:32:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaohui Li <xiaohli@redhat.com>
Subject: Re: [PATCH v4 2/5] migration: Allow network to fail even during
 recovery
Message-ID: <ZUEeKDXMuSKaGY7q@x1n>
References: <20231017202633.296756-1-peterx@redhat.com>
 <20231017202633.296756-3-peterx@redhat.com>
 <87il6m7tr1.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87il6m7tr1.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 31, 2023 at 03:26:42PM +0100, Juan Quintela wrote:
> > -void migration_rp_wait(MigrationState *s)
> > +int migration_rp_wait(MigrationState *s)
> >  {
> > +    /* If migration has failure already, ignore the wait */
> > +    if (migrate_has_error(s)) {
> > +        return -1;
> > +    }
> > +
> >      qemu_sem_wait(&s->rp_state.rp_sem);
> > +
> > +    /* After wait, double check that there's no failure */
> > +    if (migrate_has_error(s)) {
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> >  }
> 
> Shouldn't this be bool?
> 
> We have (too many) functions in migration that returns 0/-1 and set an
> error, I think we should change them to return bool.  Or even just test
> if err is set.

Yeah this patch comes earlier than "switching to bools".  I can make them
bool after I rebase to the new pulls and see what's leftover.  Thanks.

-- 
Peter Xu


