Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7B89962E4
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Oct 2024 10:34:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syS9g-0000Gh-1y; Wed, 09 Oct 2024 04:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1syS9b-00008T-8Q
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:34:43 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1syS9X-0000iw-BP
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:34:42 -0400
Received: from [IPV6:2a02:a03f:eafe:6901:38ac:f342:2515:2d3c] (unknown
 [IPv6:2a02:a03f:eafe:6901:38ac:f342:2515:2d3c])
 by apollo.dupie.be (Postfix) with ESMTPSA id 3EEB11520F1F;
 Wed,  9 Oct 2024 10:34:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1728462873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ep2hhwI6KvfY4AUamjkazDBhUwe+I5bt8VjEdrVWla0=;
 b=h2v9m0Fx2FQzHWZ/c4KxfJdXfk1qr9FBS0eqR84g21c4Xb3QUajL+gWFuQY0i74gDulSKE
 oOuhM4XAirIS4EYUmgxXQ7+MLgXHroX4ritfOs27HHuzCJaiUTVStKBVhSRIC50S1ZD3CL
 iawmif3nmyK4Sc+ddUJ5WCFiNJfAw4mSYQCySVSsTnT31XCpe1u0eRUL2Kr+J/bYoEkjWY
 9u99CoP5u8ObQPom5CbTX2bQsFD6fzzmFWP4tT6dWlLEJ2/VyG1qJp6YWndn+yabv7uFCj
 DXQB4NNa+bcCk478d6TNHux/w+I8rkSFjwmtb03wRoLo4sOyVtsjir9KckOs+g==
Message-ID: <b0a518bc-a600-4d0d-b1c9-5b43f95c90b9@dupond.be>
Date: Wed, 9 Oct 2024 10:34:33 +0200
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH] qga: skip bind mounts in fs list
To: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com
References: <20241002100634.162499-2-jean-louis@dupond.be>
Content-Language: en-US
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <20241002100634.162499-2-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/10/2024 12:06, Jean-Louis Dupond wrote:
> The filesystem list in build_fs_mount_list should skip bind mounts.
> This because we end up in locking situations when doing fsFreeze. Like
> mentioned in [1] and [2].
>
> Next to that, the build_fs_mount_list call did a fallback via
> build_fs_mount_list_from_mtab if mountinfo did not exist.
> There it skipped bind mounts, but this is broken for newer OS.
> This as mounts does not return the path of the bind mount but the
> underlying dev/partition, so S_ISDIR will never return true in
> dev_major_minor call.
>
> This patch simply checks the existing devmajor:devminor tuple in the
> mounts, and if it already exists, this means we have the same devices
> mounted again, a bind mount. So skip this.
>
> Same approach is used in open-vm-tools [3].
>
> [1]: https://gitlab.com/qemu-project/qemu/-/issues/592
> [2]: https://gitlab.com/qemu-project/qemu/-/issues/520
> [3]: https://github.com/vmware/open-vm-tools/commit/d58847b497e212737007958c945af1df22a8ab58
>
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> ---
>   qga/commands-linux.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> index 51d5e3d927..426b040ab8 100644
> --- a/qga/commands-linux.c
> +++ b/qga/commands-linux.c
> @@ -59,6 +59,22 @@ static int dev_major_minor(const char *devpath,
>       return -1;
>   }
>   
> +/*
> + * Check if we already have the devmajor:devminor in the mounts
> + * If thats the case return true.
> + */
> +static bool dev_exists(FsMountList *mounts, unsigned int devmajor, unsigned int devminor)
> +{
> +    FsMount *mount;
> +
> +    QTAILQ_FOREACH(mount, mounts, next) {
> +        if (mount->devmajor == devmajor && mount->devminor == devminor) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
>   static bool build_fs_mount_list_from_mtab(FsMountList *mounts, Error **errp)
>   {
>       struct mntent *ment;
> @@ -89,6 +105,10 @@ static bool build_fs_mount_list_from_mtab(FsMountList *mounts, Error **errp)
>               /* Skip bind mounts */
>               continue;
>           }
> +        if (dev_exists(mounts, devmajor, devminor)) {
> +            /* Skip already existing devices (bind mounts) */
> +            continue;
> +        }
>   
>           mount = g_new0(FsMount, 1);
>           mount->dirname = g_strdup(ment->mnt_dir);
> @@ -172,6 +192,11 @@ bool build_fs_mount_list(FsMountList *mounts, Error **errp)
>               }
>           }
>   
> +        if (dev_exists(mounts, devmajor, devminor)) {
> +            /* Skip already existing devices (bind mounts) */
> +            continue;
> +        }
> +
>           mount = g_new0(FsMount, 1);
>           mount->dirname = g_strdup(line + dir_s);
>           mount->devtype = g_strdup(dash + type_s);


Ping + add kkostiuk@redhat.com as I missed him in the initial mail.


