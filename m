Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 657917B9B62
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 09:31:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoIoi-0002di-DV; Thu, 05 Oct 2023 03:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoIog-0002dS-IF
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoIof-0006pC-51
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696491036;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RxB1/w0jfmIV9oebtgwdbW5Iewp+bawEkNScUYTqV90=;
 b=K/OJJgGo/AcnNGgL5UGzjRDjIsMqMNDFQMpHz/Qmocl6TSr2lqOsvbYm7RGIzJMoHw9Est
 JZbvzfVmhIyXTJhGdQtzOWvWVv2FzoPIDKdn2AJP3CLUDUPLd9zQJyqPdWZtkvDOBmiMP+
 DUCHsBeP0GJtElcTtapOsOnYu6CqdVA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-kxb3xPa-MRCXLQFmy1zL-g-1; Thu, 05 Oct 2023 03:30:34 -0400
X-MC-Unique: kxb3xPa-MRCXLQFmy1zL-g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32320b9d671so580418f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 00:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696491033; x=1697095833;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RxB1/w0jfmIV9oebtgwdbW5Iewp+bawEkNScUYTqV90=;
 b=RsIB5I90ZPBxy849YYSK4+Wp/G8rd37wWQEbE2Nm5SXkPSDcGwc7kHQNyeULa6tCMK
 PjC2wmWfl02RxGTxrCTqcMLlE3EvTWUVUB2BKw6Eh85l+lK+F8XO3q/40nXrk5iw3sVK
 zRP/OkE/6dGQjgNsizad8RpvCP5/cdMyYrBiP2nyErrVB5zKbp7Hh4DXipOKIU8GhEvV
 sID+9LBZbzZfph+ttfXtIG0cQwJHhyAALCKNxcvVAAtDUDd12j3Pq6S5Z4AmhWMexMri
 rSNt38YdB92RuzfY27Zpha6Bt7LEZmanrewzBRttv8RWtlSZLx+HdnXC9KDZcGOF7VC8
 ICig==
X-Gm-Message-State: AOJu0YykcRE2W7nuOVziIC/Y2kPU+DgH1hBFAUfLTSN1ao1DVxw/7mBg
 jJaNQEX5JW8y/5YqdgXw4Lctft8HGlHPz7lKZsUUBLbK3iaBA5l/tF6OusQvIQI4GpN3FnZtOWk
 upQkG5q6dAuxl7dM=
X-Received: by 2002:a5d:58f2:0:b0:31f:f326:766b with SMTP id
 f18-20020a5d58f2000000b0031ff326766bmr3826634wrd.6.1696491032998; 
 Thu, 05 Oct 2023 00:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZXYcgplLcYinE6ZPBYkAKFU8pz8Ugor6W3b2I0jlLUHdjQh/nu36gR9NJE8jdpElwJjPWOw==
X-Received: by 2002:a5d:58f2:0:b0:31f:f326:766b with SMTP id
 f18-20020a5d58f2000000b0031ff326766bmr3826621wrd.6.1696491032710; 
 Thu, 05 Oct 2023 00:30:32 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 p16-20020a5d4e10000000b0031fa870d4b3sm1069324wrt.60.2023.10.05.00.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 00:30:32 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 02/10] migration: Introduce migrate_has_error()
In-Reply-To: <20231004220240.167175-3-peterx@redhat.com> (Peter Xu's message
 of "Wed, 4 Oct 2023 18:02:32 -0400")
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-3-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 05 Oct 2023 09:30:31 +0200
Message-ID: <87mswxpluw.fsf@secure.mitica>
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

Peter Xu <peterx@redhat.com> wrote:
> Introduce a helper to detect whether MigrationState.error is set for
> whatever reason.
>
> This is preparation work for any thread (e.g. source return path thread) to
> setup errors in an unified way to MigrationState, rather than relying on
> its own way to set errors (mark_source_rp_bad()).
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
queued


