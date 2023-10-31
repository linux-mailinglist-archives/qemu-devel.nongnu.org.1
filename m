Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C7C7DCE03
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:40:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxoGE-0000WX-Dz; Tue, 31 Oct 2023 08:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxoGC-0000U1-OB
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 08:54:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxoGB-0003x4-2r
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 08:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698756858;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jKwGP4QsAf/WN5eLf6PpPT5RrGM6N4ok1zUXPQQCjm8=;
 b=ME7ERmQQ2fUlVNUknibWxuTBx5a2M3SNeebxjUNIHSkZdOiRRM/5o+dFkXgltuy2QXG/NU
 48LrkzvxS3kyW6YtFoETeO05QIFhYtXYkR2B/il78nDeoir7SvrF1Oj9wo9c2lD1e+07zZ
 NLaNjlNhXnazjsR3Zch8A009UVCQ+1Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-Gy0bWCCkNbaHG_HPzVPq1w-1; Tue, 31 Oct 2023 08:54:07 -0400
X-MC-Unique: Gy0bWCCkNbaHG_HPzVPq1w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4083c9b426fso38621495e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 05:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698756846; x=1699361646;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKwGP4QsAf/WN5eLf6PpPT5RrGM6N4ok1zUXPQQCjm8=;
 b=ZYf9ay1RSxFlnY5DUaxmCPwtWOeXyEk1DQk/3jLEqKq3mZ/O+2b3KWs6qbILtYCn63
 NTymUF3ecizoMLH/xZIpOOFvtafp3A0hKtqUL/oz/qRVFtcRb8opyKunOkd/C4crf7yK
 PE2nH/8EjyqFmdqGJotgujzG3NKPXYXKbft2xjct1v1hyOwcxycBdt5vhOIGLY2VmxXQ
 fSK1OVqsxGJl6yEWJTeuJwEtz6QN82R/ZB9nWRSBF+DbAMEOxiKWf2pp1Lc7KudsT1Ft
 7D2uECOsyVTkcPD4SGTXXk0FKsvTyFjwMH1v23+ONUy/kjDyeu5F50vTui0VAf+eIVmY
 erAw==
X-Gm-Message-State: AOJu0YwMa16Yyd0k/qHORgKoOlcA+m1d+hdVA7gFFiqXp6Aa57zUFsIg
 hCouG8pVWwmzA5YSiLSCZfkvhngL7LYMxQ6cdsWVaE/UOtCv4X8h+dTuUjz7CK5gyTzHVuRNSHO
 7e2XbBZGeWoCeDAQ=
X-Received: by 2002:a05:600c:3591:b0:408:cd96:7164 with SMTP id
 p17-20020a05600c359100b00408cd967164mr10950358wmq.9.1698756845944; 
 Tue, 31 Oct 2023 05:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkzvptpUOEwI06EAI9zlJ3btuWcGHIp0EWdfLH/0NHEYCYJwHhQTN/o0oYyYfuao9yeZdrog==
X-Received: by 2002:a05:600c:3591:b0:408:cd96:7164 with SMTP id
 p17-20020a05600c359100b00408cd967164mr10950339wmq.9.1698756845514; 
 Tue, 31 Oct 2023 05:54:05 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 f3-20020adff983000000b0032d9caeab0fsm1448356wrr.77.2023.10.31.05.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 05:54:04 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Joao Martins
 <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 5/5] migration: Add tracepoints for downtime checkpoints
In-Reply-To: <20231030163346.765724-6-peterx@redhat.com> (Peter Xu's message
 of "Mon, 30 Oct 2023 12:33:46 -0400")
References: <20231030163346.765724-1-peterx@redhat.com>
 <20231030163346.765724-6-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 13:54:04 +0100
Message-ID: <87edhb7y1f.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> This patch is inspired by Joao Martin's patch here:
>
> https://lore.kernel.org/r/20230926161841.98464-1-joao.m.martins@oracle.com
>
> Add tracepoints for major downtime checkpoints on both src and dst.  They
> share the same tracepoint with a string showing its stage.
>
> Besides the checkpoints in the previous patch, this patch also added
> destination checkpoints.
>
> On src, we have these checkpoints added:
>
>   - src-downtime-start: right before vm stops on src
>   - src-vm-stopped: after vm is fully stopped
>   - src-iterable-saved: after all iterables saved (END sections)
>   - src-non-iterable-saved: after all non-iterable saved (FULL sections)
>   - src-downtime-stop: migration fully completed
>
> On dst, we have these checkpoints added:
>
>   - dst-precopy-loadvm-completes: after loadvm all done for precopy
>   - dst-precopy-bh-*: record BH steps to resume VM for precopy
>   - dst-postcopy-bh-*: record BH steps to resume VM for postcopy
>
> On dst side, we don't have a good way to trace total time consumed by
> iterable or non-iterable for now.  We can mark it by 1st time receiving a
> FULL / END section, but rather than that let's just rely on the other
> tracepoints added for vmstates to back up the information.
>
> With this patch, one can enable "vmstate_downtime*" tracepoints and it'll
> enable all tracepoints for downtime measurements necessary.
>
> Drop loadvm_postcopy_handle_run_bh() tracepoint alongside, because they
> service the same purpose, which was only for postcopy.  We then have
> unified prefix for all downtime relevant tracepoints.
>
> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


