Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFB8828861
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 15:43:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNDJo-0002H1-D2; Tue, 09 Jan 2024 09:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rNDJf-0002DI-71
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:42:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rNDJc-0008Ea-V1
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704811371;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3/1i33Cd7FyoizOFVn2lBV/V0Zvb68uq/ljO8qTpRuo=;
 b=KrMv4/+Iahs1NGRb8/T4yKe6b+O77Vh1pUOOcJObSwfjA0Wx6Q5fOnBaGgXLSheChyMLBs
 U177g/BYNlgYD31GOwsAeMIPETy8GkZDFQzf8aoWF7BD1AcKyjZWMDiKHwFNRozsrJZGvH
 pD2OXYxKWCGgkAbScrwqP6U0ZVh8wO0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-c3JLGJiIMkiyrVnTbkqHtA-1; Tue, 09 Jan 2024 09:42:48 -0500
X-MC-Unique: c3JLGJiIMkiyrVnTbkqHtA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F290285A58B;
 Tue,  9 Jan 2024 14:42:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 058EB2166B33;
 Tue,  9 Jan 2024 14:42:45 +0000 (UTC)
Date: Tue, 9 Jan 2024 14:42:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] target/s390x/kvm/pv: Provide some more useful
 information if decryption fails
Message-ID: <ZZ1bY3qm3EvKxLWl@redhat.com>
References: <20240109143038.155512-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240109143038.155512-1-thuth@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jan 09, 2024 at 03:30:38PM +0100, Thomas Huth wrote:
> It's a common scenario to copy guest images from one host to another
> to run the guest on the other machine. This (of course) does not work
> with "secure exection" guests since they are encrypted with one certain
> host key. However, if you still (accidentally) do it, you only get a
> very user-unfriendly error message that looks like this:

Not a comment on the patch, but my own interest how/where does the
disk image encryption/decryption happen ?  Is that in guest kernel
context, and any info on what format the encryption uses ?

> 
>  qemu-system-s390x: KVM PV command 2 (KVM_PV_SET_SEC_PARMS) failed:
>   header rc 108 rrc 5 IOCTL rc: -22
> 
> Let's provide at least a somewhat nicer hint to the users so that they
> are able to figure out what might have gone wrong.
> 
> Buglink: https://issues.redhat.com/browse/RHEL-18212
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/s390x/kvm/pv.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
> index 6a69be7e5c..2833a255fa 100644
> --- a/target/s390x/kvm/pv.c
> +++ b/target/s390x/kvm/pv.c
> @@ -29,7 +29,8 @@ static bool info_valid;
>  static struct kvm_s390_pv_info_vm info_vm;
>  static struct kvm_s390_pv_info_dump info_dump;
>  
> -static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
> +static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
> +                         int *pvrc)
>  {
>      struct kvm_pv_cmd pv_cmd = {
>          .cmd = cmd,
> @@ -46,6 +47,9 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
>                       "IOCTL rc: %d", cmd, cmdname, pv_cmd.rc, pv_cmd.rrc,
>                       rc);
>      }
> +    if (pvrc) {
> +        *pvrc = pv_cmd.rc;
> +    }
>      return rc;
>  }
>  
> @@ -53,12 +57,13 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
>   * This macro lets us pass the command as a string to the function so
>   * we can print it on an error.
>   */
> -#define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data)
> +#define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data, NULL)
> +#define s390_pv_cmd_pvrc(cmd, data, pvrc) __s390_pv_cmd(cmd, #cmd, data, pvrc)
>  #define s390_pv_cmd_exit(cmd, data)    \
>  {                                      \
>      int rc;                            \
>                                         \
> -    rc = __s390_pv_cmd(cmd, #cmd, data);\
> +    rc = __s390_pv_cmd(cmd, #cmd, data, NULL); \
>      if (rc) {                          \
>          exit(1);                       \
>      }                                  \
> @@ -144,12 +149,19 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
>  
>  int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
>  {
> +    int ret, pvrc;
>      struct kvm_s390_pv_sec_parm args = {
>          .origin = origin,
>          .length = length,
>      };
>  
> -    return s390_pv_cmd(KVM_PV_SET_SEC_PARMS, &args);
> +    ret = s390_pv_cmd_pvrc(KVM_PV_SET_SEC_PARMS, &args, &pvrc);
> +    if (ret && pvrc == 0x108) {
> +        error_report("Can't set secure parameters, please check whether "
> +                     "the image is correctly encrypted for this host");
> +    }
> +
> +    return ret;
>  }
>  
>  /*
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


