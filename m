Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BDB7BABB3
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 22:57:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoVOK-0002cv-W8; Thu, 05 Oct 2023 16:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qoVOH-0002ce-5F
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 16:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qoVOD-00021G-WD
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 16:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696539366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=es2CF1F9lgMg8+446HJuGiYhg32yYiMDRxbGt5pf32c=;
 b=UDmy4tKJBpVl7M9UFzIEU/Fb3uhvBA9YNry95smLGex4mpSBHKU3m/i3T3fGzzuRQBcX9Y
 8dBmm6vnvTPSbiuPyximKrmU2b84cwoics+p+8fALbL/kFMeVO34ymUxyA/AzPDoum1yos
 yyBKASVZIq9WBuizl4WuTURP6tFVCYs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-745fp7JOOoeTRxzvY0j-jA-1; Thu, 05 Oct 2023 16:55:55 -0400
X-MC-Unique: 745fp7JOOoeTRxzvY0j-jA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4194e7f41e1so1978751cf.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 13:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696539355; x=1697144155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=es2CF1F9lgMg8+446HJuGiYhg32yYiMDRxbGt5pf32c=;
 b=KCPfeZqTnPWF7VcVtXqq60Mei661c+JR0CvTlJRM4htgEUM4A5YNZczyJ1XcncdobP
 FB9DEUi1yuU21xpgXodshs35iJwtzFk99SFCDho3CuZ3sy8dLinpE27adSvcOrutlW/s
 FSekAfgAWqYy4wJTGJLMtiA0WHBcFw/2fftXNQD61yuj0fHF6H34O4e0Y4y0BUfwl7CS
 4rXhfzS1zdK8rpd9xjpFC7P5pkTPDXi81K21sYhr5y1pSIN6LZXnIQCux9uOx3eRVVXi
 vReF6kchM+oRdCAm4IqjRwxA9CvyLOSnSY3yDlIPii1NQeaZTSzBkphP5L5t4Mb6I84m
 yppA==
X-Gm-Message-State: AOJu0Yw1Ly5ollhqaPuaaXPxKBDtAm5GbMRiH6l8C67Dt0wSOPi3QBYF
 nTPTbTtH2gWnVT2fVVYuVfMfuo47UyyRqBMGXIxg6lOfhe2b90sb7/KCgfrO5Q3XHiThs7HzM/K
 swVQsDhGk3x/XxFY=
X-Received: by 2002:a05:622a:1313:b0:411:ff8f:d5aa with SMTP id
 v19-20020a05622a131300b00411ff8fd5aamr7350089qtk.3.1696539354920; 
 Thu, 05 Oct 2023 13:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFulzlQF2xHnb1rAD3wAb3SWeMpwYug9jkYNW72mXtwE647ZoZ0o6qSHq9N0wF6l8ZITSeZUA==
X-Received: by 2002:a05:622a:1313:b0:411:ff8f:d5aa with SMTP id
 v19-20020a05622a131300b00411ff8fd5aamr7350081qtk.3.1696539354680; 
 Thu, 05 Oct 2023 13:55:54 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 jy13-20020a05622a818d00b00419af3b81f0sm748888qtb.37.2023.10.05.13.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 13:55:54 -0700 (PDT)
Date: Thu, 5 Oct 2023 16:55:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 10/10] tests/migration-test: Add a test for postcopy
 hangs during RECOVER
Message-ID: <ZR8iwwOeXWI+x9YX@x1n>
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-11-peterx@redhat.com>
 <87edi9fbh5.fsf@suse.de> <878r8hfavf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878r8hfavf.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 05, 2023 at 10:37:56AM -0300, Fabiano Rosas wrote:
> >> +    /*
> >> +     * Make sure both QEMU instances will go into RECOVER stage, then test
> >> +     * kicking them out using migrate-pause.
> >> +     */
> >> +    wait_for_postcopy_status(from, "postcopy-recover");
> >> +    wait_for_postcopy_status(to, "postcopy-recover");
> >
> > Is this wait out of place? I think we're trying to resume too fast after
> > migrate_recover():
> >
> > # {
> > #     "error": {
> > #         "class": "GenericError",
> > #         "desc": "Cannot resume if there is no paused migration"
> > #     }
> > # }
> >
> 
> Ugh, sorry about the long lines:
> 
> {
>     "error": {
>         "class": "GenericError",
>         "desc": "Cannot resume if there is no paused migration"
>     }
> }

Sorry I didn't get you here.  Could you elaborate your question?

Here we wait on both sides and make sure they'll all be in RECOVER stage,
and we should know that they won't proceed further because the pipes
contain mostly nothing so they'll just block at the pipes.  What did I
miss?

Thanks,

-- 
Peter Xu


