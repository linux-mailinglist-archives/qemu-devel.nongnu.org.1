Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FFA7B9B86
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 09:50:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoJ70-0006N6-6a; Thu, 05 Oct 2023 03:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoJ6y-0006LO-9c
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoJ6x-00055D-12
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696492170;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Ifac4cuvuwrKIQuo6GOybK65cifG6KAUpjNFeHNEZkI=;
 b=g0RevXv1xEzubTr11L//IqMTnfzVGocExPcf7boB52hdbN2ywcyM6Jz1YCNMsXVDwro05C
 CaNd2vIo/W6GIdRwVU6OinOFXSPf72JZQp160olQCs1cUj/E8DNreDlHOeSlHBWNTuaX4+
 X4loN16hmrcm5elf76BzA1QWKqLyiRg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-Q67yOM58OCmEmqC2BaCn-Q-1; Thu, 05 Oct 2023 03:49:28 -0400
X-MC-Unique: Q67yOM58OCmEmqC2BaCn-Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso533529f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 00:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696492167; x=1697096967;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ifac4cuvuwrKIQuo6GOybK65cifG6KAUpjNFeHNEZkI=;
 b=ZyoaIAJSLkHEZn41kkRQ/cR4Cj1NAD41mmHwUQxvU6+IAbzq8HRm/esMBr9UXccmz/
 WNhGs3kPMguRcje63eo2hs5LHxH+yJrdxlO0S2Shf880osiMmOl/5+EN6jYaaD1oUUVb
 VzDFkMxcUiVt18iwmkMcgnk2h+3jvxIPxgB15DPFbiQrFIG2j3ysh5yqj6ht5Xk1RVd+
 2cWJTqAG2fQU9u+Zal/Rfg74w6K97Ng5OrV/qH3e51Q8Q/kdNjUEXpUAtCvzrH5JUpVG
 FbOBj9B4DXhqF3OHxWg085greNaTosx9nEr0327LWdk6a42AX4CZeiXhpYCfYYJtT+O5
 NCuA==
X-Gm-Message-State: AOJu0Yye9+BOI928Hm8fIkt85Cr4bSO2A727CKZ1XfuWTSgsvf9Xh83x
 PicPJ3iyJRdvSVQtjN3Rg1SW+yz4tyB/AOZsvA9gMz8l2RoctiWXn2uV+8xaQqMrG5Np+7voymc
 DaCa25R1sx13PFUM=
X-Received: by 2002:a5d:53d1:0:b0:314:1230:29b0 with SMTP id
 a17-20020a5d53d1000000b00314123029b0mr4161775wrw.52.1696492167467; 
 Thu, 05 Oct 2023 00:49:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEm6BISjVa38gh634CramHOVp50xEJpimoKNLpBsYrUI/Oa410q1yJzJcoyl9zuM5usHP9+g==
X-Received: by 2002:a5d:53d1:0:b0:314:1230:29b0 with SMTP id
 a17-20020a5d53d1000000b00314123029b0mr4161760wrw.52.1696492167173; 
 Thu, 05 Oct 2023 00:49:27 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 n5-20020a5d67c5000000b00317f70240afsm1102329wrw.27.2023.10.05.00.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 00:49:26 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 07/10] migration: Add migration_rp_wait|kick()
In-Reply-To: <20231004220240.167175-8-peterx@redhat.com> (Peter Xu's message
 of "Wed, 4 Oct 2023 18:02:37 -0400")
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-8-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 05 Oct 2023 09:49:25 +0200
Message-ID: <874jj5pkze.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> It's just a simple wrapper for rp_sem on either wait() or kick(), make it
> even clearer on how it is used.  Prepared to be used even for other things.
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I agree with the idea, but I think that the problem is the name of the
semaphore.


> +void migration_rp_wait(MigrationState *s)
> +{
> +    qemu_sem_wait(&s->rp_state.rp_sem);

I am not sure if it would be better to have the wrappers or just rename

If we rename the remaphore to migration_thread, this becomes:

    qemu_sem_wait(&s->rp_state.return_path_ready);

    qemu_sem_post(&s->rp_state.return_path_ready);

Or something similar?


