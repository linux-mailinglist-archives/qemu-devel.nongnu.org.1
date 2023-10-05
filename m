Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5D97BAB9F
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 22:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoVGK-00010J-IH; Thu, 05 Oct 2023 16:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qoVGG-000109-Hh
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 16:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qoVGE-0007W6-Od
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 16:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696538873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qBJngKnD41yJ/G1yj4t1L4sOyQjkicC1dIlXJgveiDs=;
 b=SxSBpHaAjoNZD9wa9LfzYrc9Q5F2v6kHzEMiOJh4iurMoRXpz72FJtruQMinvle1rHrkRa
 RLzym1x1I4ghh1/COhZ35YX4BiVlqr9xjZTrXgbPDQp/xFnco/0r6C2RzTHyv9RSCALFer
 YDH6i7/IaMPnl2bmW0VzCoWBTNQbcdg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-4rMbZltrNhiBRyU6DweWUQ-1; Thu, 05 Oct 2023 16:47:51 -0400
X-MC-Unique: 4rMbZltrNhiBRyU6DweWUQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4182f829a79so2344181cf.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 13:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696538871; x=1697143671;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qBJngKnD41yJ/G1yj4t1L4sOyQjkicC1dIlXJgveiDs=;
 b=u+eZDlvnfJ2mGeUZWWMRfK+ilwdPlUZ8Gw+ikFfpQZ3uuq84dF3GI6e9gelBW+HFsY
 3fzzHV9DtFiELbVmA2l7RSvmujUe9E1iFvfLTzYjLUZ28WE7v25fNhEEsw/rG0nx7nVw
 x2HeVmkH4+EYgYeH0dLofKXauqE3ZhsZuzupLljSOQYrvYupH64IIHryoMeOi4W0oSmP
 0RC6HZUuPQjmuaGIeHnOTCxNzPQ5DvvXx9ILaFXoljRmq8iBNOH6cgfYHXP2pOBdbctA
 f9InfJJarF8nBXrsXirYQAgBgjcnWx7eg8CfIh50fXyoE0DihRPDKqllGXkDtWkXo9FJ
 6bbw==
X-Gm-Message-State: AOJu0YyihcKPsEtqxD3zs6kc6/9ySzlEHAh0VNoMmXu6xPsjIwXRnD75
 Pd9DJU7IN+eBS3wphusvZ+b9ufMs2m7iSgRY9i7LM441Rw92ddBRvBKg7/+t5Z4nL2yAtn//WO+
 D3CZQDsN9S0g6odU=
X-Received: by 2002:ac8:5a8a:0:b0:412:1aa7:786 with SMTP id
 c10-20020ac85a8a000000b004121aa70786mr7624797qtc.1.1696538871200; 
 Thu, 05 Oct 2023 13:47:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrktARyqo7aHI1nKJVkc6EsPnQSL8p3ID22VyXDZoD+NN/TlI2NWnqrWCFuBVWnkMtHhez3g==
X-Received: by 2002:ac8:5a8a:0:b0:412:1aa7:786 with SMTP id
 c10-20020ac85a8a000000b004121aa70786mr7624786qtc.1.1696538870854; 
 Thu, 05 Oct 2023 13:47:50 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 v2-20020ac873c2000000b00419576c7b75sm735502qtp.23.2023.10.05.13.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 13:47:50 -0700 (PDT)
Date: Thu, 5 Oct 2023 16:47:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 07/10] migration: Add migration_rp_wait|kick()
Message-ID: <ZR8g9K34IY95/Ser@x1n>
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-8-peterx@redhat.com>
 <874jj5pkze.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874jj5pkze.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 05, 2023 at 09:49:25AM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > It's just a simple wrapper for rp_sem on either wait() or kick(), make it
> > even clearer on how it is used.  Prepared to be used even for other things.
> >
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> I agree with the idea, but I think that the problem is the name of the
> semaphore.
> 
> > +void migration_rp_wait(MigrationState *s)
> > +{
> > +    qemu_sem_wait(&s->rp_state.rp_sem);
> 
> I am not sure if it would be better to have the wrappers or just rename
> 
> If we rename the remaphore to migration_thread, this becomes:
> 
>     qemu_sem_wait(&s->rp_state.return_path_ready);
> 
>     qemu_sem_post(&s->rp_state.return_path_ready);
> 
> Or something similar?

I'd prefer keeping a pair of helpers, but I'm open to other suggestions,
e.g. I can rename the sem at the same time, or have a better name just for
the helpers.

Thanks,

-- 
Peter Xu


