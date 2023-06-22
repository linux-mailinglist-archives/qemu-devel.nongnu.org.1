Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F157373A909
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 21:37:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCQ7F-00005M-1q; Thu, 22 Jun 2023 15:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCQ7D-0008Va-6Q
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCQ7B-0004dl-MP
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687462628;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=JtHdbON11Hw/u+ZDmJktX0BRFQuqaDbQ4xBw+RfnHD8=;
 b=fQAQzK2iYnyKl7URUtZaWgTcqHZEdgcEvQit9vZ18wtcV460g75HLh9qR30s5/wdW156q/
 QlT7qZ28QG1rGDoTBB6moJi4lWXD9mp7B9UUugBxx7f7DCluOiYHDfyswDeq9GbPe3W6Tx
 mnIimxv6jAWiZAFQywUdn0sRMNze47A=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-pHYMasc6PTeDLaQ0MefDDw-1; Thu, 22 Jun 2023 15:37:05 -0400
X-MC-Unique: pHYMasc6PTeDLaQ0MefDDw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f60dd5ab21so6119931e87.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 12:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687462623; x=1690054623;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtHdbON11Hw/u+ZDmJktX0BRFQuqaDbQ4xBw+RfnHD8=;
 b=WH99P4hFOlg2HLmK44opucGFGLQ1RFZGjVPMK438XzchBJ2tya6MP7yHgqP08MDI/p
 resDiqgBIbdaehLKj46Y9aYpe5Z+Av2wH9tO89xcGkF0AUJYqgL7q8LOP0ZN6873i0hp
 0r6xmtUKcOrFpWNV7HF6dgqe0XMGY9Ir4GgPX58Eu71eueWOF7GzohlUkmvPkFvv3S1E
 1gwIIzU6lAiehNd9pWO0ttiR+0zkXsYvNyTMBfa/E7aRtCLqbjA/8sA1XXuMk7tDjzoD
 ijwEAuZLn8nq5vLniWBx4VZ+0UiPeB9J8RpfsULjixBen7YdM2IYQUa2t3nZRGSYKroG
 Uw/g==
X-Gm-Message-State: AC+VfDyzrJZxqLMSlrfK+DIyfBCIE9NWelDHYNqqHtybkLWRn4EEGgmZ
 z23L/qMOZkPwAaZrOq1W8NakD/VfKbxASSxsNtViVOuSQ3+IuAT0nbuDB0TUmhC5/Y7YYm11gnJ
 o2BxLZ9nQGFkXHRI=
X-Received: by 2002:a19:5057:0:b0:4f9:5396:ed1b with SMTP id
 z23-20020a195057000000b004f95396ed1bmr5723955lfj.28.1687462623782; 
 Thu, 22 Jun 2023 12:37:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ69o1LHKRuPNHmFtfylWEdpzKkJ78DojvQlDERTb01/4WEb/F/a6mYze8sBdc7Pe+iiP49Kvw==
X-Received: by 2002:a19:5057:0:b0:4f9:5396:ed1b with SMTP id
 z23-20020a195057000000b004f95396ed1bmr5723939lfj.28.1687462623481; 
 Thu, 22 Jun 2023 12:37:03 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 q10-20020a5d61ca000000b002fb60c7995esm7738427wrv.8.2023.06.22.12.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 12:37:02 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,
 qemu-block@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Fam Zheng <fam@euphon.net>,
 libvir-list@redhat.com
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
In-Reply-To: <ZJRn3zMwA0DVkkcD@x1n> (Peter Xu's message of "Thu, 22 Jun 2023
 11:25:19 -0400")
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
 <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
 <87wmzv7ubn.fsf@secure.mitica>
 <a81d48ac-4aee-1c5a-e530-20c634e42d5b@redhat.com>
 <ZJRn3zMwA0DVkkcD@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 21:37:02 +0200
Message-ID: <878rcbe1b5.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> On Thu, Jun 22, 2023 at 11:22:56AM +0200, Thomas Huth wrote:
>> Then simply forbid "migrate_set_parameter multifd-channels ..." if the uri
>> has been specified on the command line?
>
> Yeah, actually already in a pull (even though the pr may need a new one..):
>
> https://lore.kernel.org/r/20230622021320.66124-23-quintela@redhat.com

That is a different problem, and different solution.

It you try to set multifd_channels after migration has started, it just
fails telling that you can't change it so late.

Later, Juan.


