Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9737D3FA1
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:56:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv06G-0003Gl-Px; Mon, 23 Oct 2023 14:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qv06C-0003Ga-UN
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qv06A-0007eH-ST
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698087381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wc3YMRBKekpqo9GoU0awDi8QO01LjQ46+Zll9W/Zkhs=;
 b=CxXsFlTMBUH7w6Ktp/uo3kLU7/xdY6ccRZ55G57YMJQuSiEAouMX5hZEtM5xRci8KG1nIP
 LlnBZovw/7XDiK5JDFQ99knGd3Fr/rp612Q0l6DNMoa5X34K0bCyuYYNOb116nO5n9HUFI
 shW9x9dXbldtABzNmdHCnHphNO0YcQE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-s69JNCUbP2aVU62KZe-_7w-1; Mon, 23 Oct 2023 14:55:58 -0400
X-MC-Unique: s69JNCUbP2aVU62KZe-_7w-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77891ef5fc9so90031585a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698087357; x=1698692157;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wc3YMRBKekpqo9GoU0awDi8QO01LjQ46+Zll9W/Zkhs=;
 b=Hi4Z6Tv4mwoF5CzmfRhZB7VkPn3DaFGgklHKb1R0X26peR5QtdPyvHFWTTkNExcgUR
 71PJpD+4n4DvXTs3+XQHG0hMpyZhZo40tq9OmEtBHStkmR0N2f96rtW/SyCFLWQYlelO
 /rAZkgeopiSJniyYbWr95h25QZVPR9Px8E9w3XPjg4tFXCOXSUhlcN7qHUq3XuSTHwfu
 1tb3J1l7VBBGMy/lLVKwi08XtV5PPQn+1KvfCzJ/vt/UK341IF3wAsXBuVtaTwxnS+m9
 HmPC9KkiCMhEIa+f/FMEPMXN33q66Cu2aUMjM7ECqYqgv/VOs5corZb5CkhgULf1Hsmh
 TPfA==
X-Gm-Message-State: AOJu0YzqyWBKzfc8ZkFLu60Ec5jKjxsKcuozY5Ra5mftkN8pM9FwvHjz
 eN0lPdxG2JbsvXrhVu8hcn5LwIhPRC8nhiLZyo1Oy45gIgxFyZqYE2JvA3wjXZ/ADKMtvhzTR+z
 Gg3TTX7PMmnSwBao=
X-Received: by 2002:a05:620a:27cc:b0:776:f188:eee6 with SMTP id
 i12-20020a05620a27cc00b00776f188eee6mr10247870qkp.2.1698087357554; 
 Mon, 23 Oct 2023 11:55:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmEbJKldVjgrsg5e6BU5zY8FpZUtyQFIRWKlfdjXV3Nni6B2XWQKD35sM1Oqdmp6TPTM52cg==
X-Received: by 2002:a05:620a:27cc:b0:776:f188:eee6 with SMTP id
 i12-20020a05620a27cc00b00776f188eee6mr10247856qkp.2.1698087357191; 
 Mon, 23 Oct 2023 11:55:57 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c6-20020a05620a11a600b007756f60bcacsm2905761qkk.79.2023.10.23.11.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:55:56 -0700 (PDT)
Date: Mon, 23 Oct 2023 14:55:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: ram_save_complete() is fishy (was: Re: [PATCH] migration/ram:
 Fix compilation with -Wshadow=local)
Message-ID: <ZTbBuhMOUCwCs8Km@x1n>
References: <20231023145044.104866-1-thuth@redhat.com> <ZTaX00kf3UcQG/AF@x1n>
 <a326eafb-955b-4867-94f5-052672f93138@redhat.com>
 <75a76824-9b8e-45d3-a2ae-718295223715@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75a76824-9b8e-45d3-a2ae-718295223715@redhat.com>
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

On Mon, Oct 23, 2023 at 07:30:04PM +0200, Thomas Huth wrote:
> On 23/10/2023 19.11, Thomas Huth wrote:
> > On 23/10/2023 17.57, Peter Xu wrote:
> > > On Mon, Oct 23, 2023 at 04:50:44PM +0200, Thomas Huth wrote:
> > > > No need for a new variable here, especially not for one that shadows
> > > > a variable from the beginning of the function scope. With this change
> > > > the code now successfully compiles with -Wshadow=local.
> > > > 
> > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > ---
> > > >   migration/ram.c | 3 +--
> > > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > index 92769902bb..9de9e54fa9 100644
> > > > --- a/migration/ram.c
> > > > +++ b/migration/ram.c
> > > > @@ -3238,8 +3238,7 @@ static int ram_save_complete(QEMUFile *f,
> > > > void *opaque)
> > > >           ram_flush_compressed_data(rs);
> > > > -        int ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
> > > > -        if (ret < 0) {
> > > > +        if (rdma_registration_stop(f, RAM_CONTROL_FINISH) < 0) {
> > > 
> > > We may need to rename "ret" to something else?  qemu_file_set_error(),
> > > right below, will reference the error returned.
> > > 
> > > >               qemu_file_set_error(f, ret);   <-----------------
> > 
> > Oh, drat, right ... that's exactly one of the reasons why shadowing
> > variables is a bad idea ;-)
> > 
> > I'll redo a v2.
> 
> Actually, there is more fishy stuff in this function:
> 
> static int ram_save_complete(QEMUFile *f, void *opaque)
> {
>     ...
>     int ret = 0;
>     ...
>     WITH_RCU_READ_LOCK_GUARD() {
>         ...
>         ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
>         if (ret < 0) {
>             qemu_file_set_error(f, ret);
> ### here we use the outer "ret" variable         ###

[1]

>         }
>         ...
>         while (true) {
>             int pages;
> 
>             pages = ram_find_and_save_block(rs);
>             /* no more blocks to sent */
>             if (pages == 0) {
> ### here we break without touching "ret" (preserving the previous error) ###
>                 break;
>             }
>             if (pages < 0) {
>                 ret = pages;
> ###  we only replace the outer "ret" in this break-case here
>                 break;
>             }
>         }
>         ...
>         int ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
> ### so while ret from rdma_registration_start() might be propageted
> ### below, the ret from rdma_registration_stop() is only local here?
>         if (ret < 0) {
>             qemu_file_set_error(f, ret);

[2]

>         }
>     }
> 
>     if (ret < 0) {
> ### this might trigger by the "ret" from rdma_registration_start() but
> ### not by the one from rdma_registration_stop()? ... very weird...
>         return ret;
>     }
> 
> Looks like commit 48408174a7ec7 messed up with the return types pretty badly
> ... any suggestions what's the right way forward here? Should the return
> value of rdma_registration_start() only be used for the
> qemu_file_set_error(), too? Or should the return value of
> rdma_registration_stop() be allowed to be used for the "return ret" at the
> end, too?

Right that's indeed confusing, but it seems confusing too even before that
commit.  AFAICT, we should "break" for both [1][2] above for any error
occured..

Thanks,

-- 
Peter Xu


