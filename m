Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0FE7D0BA5
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:25:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtljX-0004l7-Up; Fri, 20 Oct 2023 05:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtljV-0004h1-2W
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:23:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtljK-0003KP-Vj
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697793820;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=z7SfVjMSbSJ+yobELIuZ7BO5xH7UYcQtHIBS0XP9T0Q=;
 b=c61UFjhdzH+H4mbwot9c3MgdAsL94aRMpZLaqlTxyJKUKIZ/XF7cL0VV4TObV1DkuTy0fx
 npiBIUKNMB2z/XCWfM3tGRVjKiRBzma6qVWgul0zmEBPFc0iY9bbppzcj1BG21jrMS8c6a
 WKmOoKYTwIHKudxb+MzzA5+p2pd3nxI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-w9xm-M57MbKnf1_wkrjYTQ-1; Fri, 20 Oct 2023 05:23:29 -0400
X-MC-Unique: w9xm-M57MbKnf1_wkrjYTQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507a3ae32b2so570942e87.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 02:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697793807; x=1698398607;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z7SfVjMSbSJ+yobELIuZ7BO5xH7UYcQtHIBS0XP9T0Q=;
 b=KWwXcNEsrHv5HOzQLgLSJ1lAhnHnCWYH6yOpkm6+NnAKnha9xIApgJ6KTNLabrAIqy
 zTopi17tN3IMlCEWadyVsTshG8AFNMFKKHjNcEDY89nrysuh2k/jSUcXOhKX9VD5iH1D
 br1n0lbUvhZ6bcV190fmSxUnHZt0zaAd3ZpUUqQDprPaaQEVqsc+u60/05VPhFPdI01C
 87DJP/got1MVIXCqcZi8tVaUjDkAjosTTTFL0vUjmdBcX0HG9jbEE36DnFpMFfBXiHed
 Jrs7+YDUXm0PLu3r7QKYzUZLK+4JZADiCfcDSbpa8Jbi/D5cVF7ChO6tcMIu/JCsgsse
 Za3A==
X-Gm-Message-State: AOJu0YxL8OR1dkrlPcwgy9zKsWuWbIskjgHaFzqltDqvedk1KN3N1lkh
 T5kMeZ5mDaf9WuIJZF+aFJkJYNaML8WGiCSCts6sE3vkOvtLEyKeQnXHkJLcA8cdC+8/H16fn3+
 V/JGCcsO4vDPVcL0=
X-Received: by 2002:ac2:485a:0:b0:500:a08e:2fcf with SMTP id
 26-20020ac2485a000000b00500a08e2fcfmr809883lfy.47.1697793807601; 
 Fri, 20 Oct 2023 02:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGidAucsshTR87AsxTqYA7xoYgWFHbc1LBPscq0xA2V/OZjT1dwz2jxsODTZEKkLpJLdHZUqw==
X-Received: by 2002:ac2:485a:0:b0:500:a08e:2fcf with SMTP id
 26-20020ac2485a000000b00500a08e2fcfmr809869lfy.47.1697793807163; 
 Fri, 20 Oct 2023 02:23:27 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 b16-20020a5d5510000000b0032d2489a399sm1250291wrv.49.2023.10.20.02.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 02:23:26 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V1 0/4] Live Update reboot mode
In-Reply-To: <26e34256-4b80-4b14-927b-47191c4586ce@oracle.com> (Steven
 Sistare's message of "Thu, 19 Oct 2023 17:18:06 -0400")
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <26e34256-4b80-4b14-927b-47191c4586ce@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 11:23:26 +0200
Message-ID: <877cnh1wc1.fsf@secure.mitica>
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

Steven Sistare <steven.sistare@oracle.com> wrote:
> BTW, this series depends on the patch "migration: simplify blockers".

simplify blockers and simplify notifiers are in the PULL request just
sent.

Later, Juan.


