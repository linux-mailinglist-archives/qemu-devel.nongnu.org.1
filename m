Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EA6724DA9
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 22:05:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6cu5-0007l9-Qc; Tue, 06 Jun 2023 16:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6cu3-0007kj-Rx
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 16:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6cu2-00058H-9X
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 16:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686081817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QRNMdfOUGR50gcRjyWaarCIzNXVaKlE/CGuzcOGE4jI=;
 b=O6C5LuYEgIl0IiOtjimZMMeKB9WpQwJJ+QwsR+g53KZGcSi3bhVYJHX/D6g/G8k7yWhLro
 XpeXVQypmC2yimv1xORmoczxFUknOzzehe5VTIeEUus2woOKm0iUvzMQJxz1Cz8Q9LB3fF
 j2W1278dU8Dy9v694WNB/8o+LenCSmw=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-a44pV9BUOwGDveaAah_TMg-1; Tue, 06 Jun 2023 16:03:33 -0400
X-MC-Unique: a44pV9BUOwGDveaAah_TMg-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6b29bb6a75cso31588a34.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 13:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686081812; x=1688673812;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QRNMdfOUGR50gcRjyWaarCIzNXVaKlE/CGuzcOGE4jI=;
 b=PD6fZPqwm7j1KYVa2If9sReE9okALJDyb0W6e7tEqe6NXWIZqeRXE6uwPBW8oQ8MX6
 rVStPHroXMk5vyXJV0pLllOE6oGq0lxVV4CMb5p9sCb2u/zGmm6LjdO9r3W+JemvrsP8
 KQ1rufkkNOGbEbjU1N/Ye5pPMpCw2oltYq9GTKovk2iqY70b1+hBqqCkr3zKHogvjHlQ
 W/ad66Os9OaBFfVcy6qtvpfk/XZ2U+k+MCjRj+mY8zKyR8JbN1uelDGM2DW6QUwvuMU2
 dHxrTTjypSG9t+Wvl5GyNrFdqZHSEgQDLrAei2kSX0nRCRhiQph9+NqSlP10n1r8I8gB
 hNdQ==
X-Gm-Message-State: AC+VfDytwZuWEVcR7pBNAvjNQ/LwSI3YI/ZQ0d1Dg90CMAGCLLyNR4w9
 yO/OgfKRnslDmrRQL13v6mTSowyxTljmwqPLPqO4zflO0eOt96+97fWCaYrlEdIPIQblxB9tBot
 5gi6S2VSVLyG1iok=
X-Received: by 2002:aca:3bd4:0:b0:394:6388:22bb with SMTP id
 i203-20020aca3bd4000000b00394638822bbmr1266446oia.5.1686081812651; 
 Tue, 06 Jun 2023 13:03:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6wSlkFVwv3nKd8DW9RgkUOTWdcwatju8ksYbXop+2bPDugL7rpfLNuHnZSLNHxejRXvvCbQw==
X-Received: by 2002:aca:3bd4:0:b0:394:6388:22bb with SMTP id
 i203-20020aca3bd4000000b00394638822bbmr1266440oia.5.1686081812426; 
 Tue, 06 Jun 2023 13:03:32 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 j16-20020a0cc350000000b0062383edece8sm5611980qvi.91.2023.06.06.13.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 13:03:31 -0700 (PDT)
Date: Tue, 6 Jun 2023 16:03:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 1/3] migration/multifd: Rename threadinfo.c functions
Message-ID: <ZH+RErNrOl1odmwE@x1n>
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-2-farosas@suse.de> <ZH99EuY3c/RqIELY@x1n>
 <87wn0gwfjs.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wn0gwfjs.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jun 06, 2023 at 04:34:31PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Jun 06, 2023 at 11:45:49AM -0300, Fabiano Rosas wrote:
> >> The code in threadinfo.c is only used for the QMP command
> >> query-migrationthreads. Make it explicit that this is something
> >> related to QMP.
> >> 
> >> The current names are also too generic for a piece of code that
> >> doesn't affect the migration directly in any way.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > Looks good here, but shall we reserve the qmp_* prefix to mostly qmp stuff
> > only?  Dropping "qmp_" in the new names would look better to me..
> >
> 
> Well, we're just putting the thread name and id on a list so that QMP
> can use them later. It is nothing "important" enough to have a generic
> name like migration_thread.
> 
> Perhaps:
> 
> thread_info_add
> thread_info_remove
> thread_info_init
> thread_info_cleanup
> 
> Anyway, as long as we drop that camel case I'm ok with just removing the
> qmp =)

Thanks.  To me OTOH it's good as long as "qmp_" dropped. :)

I don't worry on using "migration_thread_" as prefix, that's exactly what
the api does to me.  Or, migration_thread_info_*(), migration_thr_mgr_*(),
etc.

-- 
Peter Xu


