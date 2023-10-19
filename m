Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5605F7CF58F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:45:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQVL-0007gL-QN; Thu, 19 Oct 2023 06:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQV8-0007d2-AM
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQV6-0005LB-P3
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712215;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=to8gpsVvqHCup8DFMfA2DGsv5Z+6pqb2v/WCWzcceFU=;
 b=hp3TkHzHwhP+CIbHpr26HeLOY9lWBKtyQoM8BYwE6b8xxVomFlJKv2T0BrCyd+VPDNNgfp
 c8vW5qGtw6T0N/SRQK+qj/kNALabbQMLcRf8wptR05XhnhcUK5UhECdLtTY6lwrGsHnVSs
 hOZqT4cLEquYl6Oic/VXAn8cKEvlCbQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-jCFA0XZoNjK_e4_Ln1mN9Q-1; Thu, 19 Oct 2023 06:43:29 -0400
X-MC-Unique: jCFA0XZoNjK_e4_Ln1mN9Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32db43129c6so2554056f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712208; x=1698317008;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=to8gpsVvqHCup8DFMfA2DGsv5Z+6pqb2v/WCWzcceFU=;
 b=gNsdSaONiuV5PlgFD9TnUEChkQYHiW8+BH+IqdglY9cr0NfIhNA5N1kt3fgp4Ua5ww
 HbyWbSBpdrYdVLe9oy4JfANFvzsFGRfM8X3l8SmTVZEC33v7/NhU1SMlyhD2yuUSv4EG
 sK4pEn7fT+XxpYt+ygyLW24PEZPfYAASzUF+wM5KnlhYvAZaWQTH0xoBY7wbD92Oo1lm
 GR+uXKeM72phMA3AefhxNNai+JVXn2HliknRec0B9hRi81OaIu6uZwBpezJ3lZcAnuvW
 5PmT7rABWAUzYCwyl2S5wqDQ3UKWOhtvDTA2jBpqxc3QHyaK7z02EMSab2+9YHcNX1iv
 9WHg==
X-Gm-Message-State: AOJu0YyM7EDqrY1cu1c+VhBlWGR7c3JZHIvc0rmOLP6g+FcJPWBozB/r
 ActTacUXrPaajJls5Gd7TutWDbaBFnGWuWomp7OE2ZKHqxD5+vDia66i3Ty3WzMXlk1PM5xYXP8
 WvndVpa6QmO/VY7k=
X-Received: by 2002:a5d:5968:0:b0:32d:a022:855a with SMTP id
 e40-20020a5d5968000000b0032da022855amr1200262wri.20.1697712207986; 
 Thu, 19 Oct 2023 03:43:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE1TPs6SbDh9iG3pnJ1yUXx4J1aml4PGV6qsOramhleYfQfdPmusjw2crWZS7BQ6OPvE6tIg==
X-Received: by 2002:a5d:5968:0:b0:32d:a022:855a with SMTP id
 e40-20020a5d5968000000b0032da022855amr1200250wri.20.1697712207675; 
 Thu, 19 Oct 2023 03:43:27 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 bs30-20020a056000071e00b0032d9a1f2ec3sm4262215wrb.27.2023.10.19.03.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:43:27 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 6/6] migration/multifd: Bring back the 'ready'
 semaphore
In-Reply-To: <20231012140651.13122-7-farosas@suse.de> (Fabiano Rosas's message
 of "Thu, 12 Oct 2023 11:06:51 -0300")
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-7-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 12:43:26 +0200
Message-ID: <877cni7v01.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> Bring back the 'ready' semaphore, but this time make it per-channel,
> so that we can do true lockstep switching of MultiFDPages without
> taking the channel lock.
>
> Drop the channel lock as it now becomes useless. The rules for
> accessing the MultiFDSendParams are:
>
> - between sem and sem_done/ready if we're the channel
>
>     qemu_sem_post(&p->ready);
>     qemu_sem_wait(&p->sem);
>     <owns p>
>     qemu_sem_post(&p->sem_done);
>
> - between ready and sem if we're not the channel
>
>     qemu_sem_wait(&p->ready);
>     <owns p>
>     qemu_sem_post(&p->sem);
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> One issue I can see with this is that we might now have to wait at
> multifd_send_pages() if a channel takes too long to send it's packet
> and come back to p->ready. We would need to find a way of ignoring a
> slow channel and skipping ahead to the next one in line.

See my 1st patch in the series.  That is exactly what the channels_ready
sem does.  In your network is faster than your multifd channels can
write, main thread never waits on channels_ready, because it is always
positive.

In case that there are no channels ready, we wait in the sem instead of
being busy waiting.

And searching for the channel that is ready is really fast:

static int multifd_send_pages(QEMUFile *f)
{
    [...]

    qemu_sem_wait(&multifd_send_state->channels_ready);
    // taking a sem that is positive is basically 1 instruction

    next_channel %= migrate_multifd_channels();
    // we do crude load balancing here.
    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
        qemu_mutex_lock(&p->mutex);  // 1 lock instruction
        if (p->quit) {               // 1 check
            ....
        }
        if (!p->pending_job) {       // 1 check
            p->pending_job++;
            next_channel = (i + 1) % migrate_multifd_channels();
            break;
        }
        qemu_mutex_unlock(&p->mutex);  // 1 unlock (another instruction)
    }
    ....

So checking a channel is:
- taking a mutex that is almost always free.
- 2 checks
- unlock the mutex

So I can't really see the need to optimize this.

Notice that your scheme only has real advantanges if:
- all channels are busy
- the channel that becomes ready is just the previous one to
  next_channel or so

And in that case, I think that the solution is to have more channels or
faster networking.

Later, Juan.


